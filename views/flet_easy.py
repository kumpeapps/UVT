"""Minimal compatibility layer for the project's flet_easy usage.

This keeps the existing page decorators and data objects working while the app
moves to native Flet.
"""

from __future__ import annotations

import importlib.util
import sys
from dataclasses import dataclass, field
from pathlib import Path
from types import ModuleType
from typing import Callable, Optional

import flet as ft


_PAGE_REGISTRIES: list["AddPagesy"] = []


def _normalize_route(route: str) -> str:
    route = (route or "/").split("?")[0].split("#")[0].strip()
    if not route:
        return "/"
    if not route.startswith("/"):
        route = f"/{route}"
    if route != "/" and route.endswith("/"):
        route = route.rstrip("/")
    return route or "/"


def _join_route(prefix: str, route: str) -> str:
    prefix = _normalize_route(prefix)
    route = _normalize_route(route)
    if route == "/":
        return prefix
    if prefix == "/":
        return route
    return _normalize_route(f"{prefix}/{route.lstrip('/')}")


class _ShareStore:
    def __init__(self) -> None:
        self._data: dict[str, object] = {}

    def contains_key(self, key: str) -> bool:
        return key in self._data

    def get(self, key: str, default: object = None) -> object:
        return self._data.get(key, default)

    def set(self, key: str, value: object) -> None:
        self._data[key] = value


@dataclass
class Datasy:
    page: ft.Page
    view: Optional[ft.View] = None
    route_init: str = "/"
    route: str = "/"
    share: _ShareStore = field(default_factory=_ShareStore)


Viewsy = ft.View


@dataclass
class _PageHandler:
    route: str
    func: Callable[[Datasy], ft.View]
    share_data: bool = False
    page_clear: bool = False


class AddPagesy:
    def __init__(self, route_prefix: str = "") -> None:
        self.route_prefix = _normalize_route(route_prefix) if route_prefix else ""
        self._handlers: list[_PageHandler] = []
        _PAGE_REGISTRIES.append(self)

    def page(
        self,
        route: str,
        share_data: bool = False,
        page_clear: bool = False,
    ) -> Callable[[Callable[[Datasy], ft.View]], Callable[[Datasy], ft.View]]:
        def decorator(func: Callable[[Datasy], ft.View]) -> Callable[[Datasy], ft.View]:
            full_route = _join_route(self.route_prefix or "/", route)
            self._handlers.append(
                _PageHandler(
                    route=full_route,
                    func=func,
                    share_data=share_data,
                    page_clear=page_clear,
                )
            )
            return func

        return decorator


class FletEasy:
    def __init__(self, route_init: str = "/", path_views: Path | None = None) -> None:
        self.route_init = _normalize_route(route_init)
        self.path_views = Path(path_views) if path_views is not None else None
        self._view_factory: Optional[Callable[[Datasy], ft.View]] = None
        self._loaded_modules: list[ModuleType] = []
        self._root_view: Optional[ft.View] = None
        if self.path_views and self.path_views.exists():
            self._load_view_modules(self.path_views)

    def _load_view_modules(self, root: Path) -> None:
        for path in sorted(root.rglob("*.py")):
            if path.name == "__init__.py":
                continue
            module_name = f"flet_easy_autoload_{path.stem}_{abs(hash(path))}"
            spec = importlib.util.spec_from_file_location(module_name, path)
            if spec is None or spec.loader is None:
                continue
            module = importlib.util.module_from_spec(spec)
            sys.modules[module_name] = module
            spec.loader.exec_module(module)
            self._loaded_modules.append(module)

    def view(self, func: Callable[[Datasy], ft.View]) -> Callable[[Datasy], ft.View]:
        self._view_factory = func
        return func

    def _all_handlers(self) -> list[_PageHandler]:
        handlers: list[_PageHandler] = []
        for registry in _PAGE_REGISTRIES:
            handlers.extend(registry._handlers)
        return handlers

    def _build_root_view(self, page: ft.Page) -> Optional[ft.View]:
        if not self._view_factory:
            return None
        data = Datasy(page=page, route_init=self.route_init, route=page.route)
        return self._view_factory(data)

    def _build_route_view(self, page: ft.Page, route: str) -> Optional[ft.View]:
        handler = next((item for item in self._all_handlers() if item.route == route), None)
        if handler is None:
            return None

        data = Datasy(
            page=page,
            view=self._root_view,
            route_init=self.route_init,
            route=route,
            share=getattr(page, "_flet_easy_share", _ShareStore()),
        )
        page._flet_easy_share = data.share
        return handler.func(data)

    def _route_changed(self, page: ft.Page, route: str) -> None:
        normalized_route = _normalize_route(route)
        view = self._build_route_view(page, normalized_route)

        if view is None and normalized_route != self.route_init:
            page.go(self.route_init)
            return

        if view is not None:
            page.views = [view]
            page.update()

    def _main(self, page: ft.Page) -> None:
        page.title = "UVT"
        page.theme_mode = ft.ThemeMode.SYSTEM
        page.on_route_change = lambda e: self._route_changed(page, e.route)

        self._root_view = self._build_root_view(page)
        if self._root_view is not None:
            page._flet_easy_root_view = self._root_view

        page.go(self.route_init)

    def run(self) -> None:
        ft.run(self._main)