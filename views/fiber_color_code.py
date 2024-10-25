"""UVT Home"""

import flet as ft  # type: ignore
import flet_easy as fs  # type: ignore
from assets.app_colors import AppColors

fiber_color_code = fs.AddPagesy()


@fiber_color_code.page("/fiber_color_code", title="Fiber Color Code")
def fiber_color_code_page(data: fs.Datasy):
    """RJ45 Scheme Page"""
    view = data.view
    image = ft.Image(
        src="../assets/fiber_color-code.jpg",
        fit=ft.ImageFit.FIT_WIDTH,
    )
    container = ft.Container(
        bgcolor=AppColors.BG,
        # border_radius=35,
        # width=400,
        # height=850,
        content=ft.Stack(controls=[image]),
        # padding=50,
        alignment=ft.alignment.top_center
    )
    return ft.View(
        controls=[
            container,
        ],
        vertical_alignment="center",
        horizontal_alignment="center",
        appbar=view.appbar,
        bgcolor=AppColors.BG,
    )
