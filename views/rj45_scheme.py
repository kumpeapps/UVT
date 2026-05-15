"""UVT Home"""

import flet as ft  # type: ignore
from assets.app_colors import AppColors
from views import flet_easy as fs  # type: ignore

rj45_scheme = fs.AddPagesy()


@rj45_scheme.page("/rj45_scheme")
def rj45_scheme_page(data: fs.Datasy):
    """RJ45 Scheme Page"""
    view = data.view
    image = ft.Image(src="/images/rj45-wiring-schemes.png")
    container = ft.Container(
        bgcolor=AppColors.BG,
        # border_radius=35,
        # width=400,
        # height=850,
        content=ft.Stack(controls=[image]),
        # padding=50,
        alignment=ft.Alignment(0, -1),
    )
    return ft.View(
        controls=[
            container,
        ],
        vertical_alignment="center",
        horizontal_alignment="center",
        appbar=view.appbar,
        bgcolor=AppColors.BG
    )
