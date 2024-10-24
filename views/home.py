"""UVT Home"""

import flet as ft  # type: ignore
import flet_easy as fs  # type: ignore
from assets.app_colors import AppColors

home = fs.AddPagesy()


@home.page("/home", title="Home")
def home_page(data: fs.Datasy):
    """Home Page"""
    view = data.view
    page = data.page
    rj45_container = ft.Container(
        content=ft.Text(
            "RJ45 Wiring Scheme", text_align=ft.TextAlign.CENTER, max_lines=1, size=11
        ),
        image=ft.DecorationImage(src="https://img.icons8.com/color/96/000000/rj45.png"),
        on_click=lambda e: page.go("/rj45_scheme"),
    )
    copper_color_code_container = ft.Container(
        content=ft.Text(
            "Copper Color Code", text_align=ft.TextAlign.CENTER, max_lines=1, size=12
        ),
        image=ft.DecorationImage(
            src="https://img.icons8.com/color/96/000000/color-palette.png"
        ),
        on_click=lambda e: page.go("/copper/color_code"),
    )
    fiber_color_code_container = ft.Container(
        content=ft.Text(
            "Fiber Color Code", text_align=ft.TextAlign.CENTER, max_lines=1
        ),
        image=ft.DecorationImage(
            src="https://img.icons8.com/color/96/000000/color-palette.png"
        ),
        on_click=lambda e: page.go("/fiber_color_code"),
    )
    statics = ft.Container(
        content=ft.Text(
            "UV Static IP Calc", text_align=ft.TextAlign.CENTER, max_lines=1
        ),
        image=ft.DecorationImage(
            src="https://img.icons8.com/external-vectorslab-glyph-vectorslab/53/external-Network-Setting-machine-learning-vectorslab-glyph-vectorslab-2.png"
        ),
        on_click=lambda e: page.go("/uv/statics"),
    )
    images = ft.GridView(
        expand=1,
        runs_count=5,
        max_extent=150,
        child_aspect_ratio=1.0,
        spacing=5,
        run_spacing=5,
        controls=[
            rj45_container,
            copper_color_code_container,
            fiber_color_code_container,
            statics,
        ],
    )

    container = ft.Container(
        bgcolor=AppColors.BG,
        # border_radius=35,
        # width=400,
        # height=850,
        content=ft.Stack(controls=[images], alignment=ft.alignment.center),
        alignment=ft.alignment.center,
        # padding=50,
    )
    return ft.View(
        controls=[
            container,
        ],
        vertical_alignment=ft.alignment.center,
        horizontal_alignment=ft.alignment.center,
        appbar=view.appbar,
        bgcolor=AppColors.BG,
    )
