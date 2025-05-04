"""UVT Home"""

import flet as ft  # type: ignore
import flet_easy as fs  # type: ignore
from assets.app_colors import AppColors

rj45_scheme = fs.AddPagesy()


@rj45_scheme.page("/rj45_scheme", title="RJ45 Wiring Scheme")
def rj45_scheme_page(data: fs.Datasy):
    """RJ45 Scheme Page"""
    view = data.view
    image = ft.Image(src="../assets/images/rj45-wiring-schemes.png")
    container = ft.Container(
        bgcolor=AppColors.BG,
        # border_radius=35,
        # width=400,
        # height=850,
        content=ft.Stack(controls=[image]),
        # padding=50,
        alignment=ft.alignment.top_center,
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
