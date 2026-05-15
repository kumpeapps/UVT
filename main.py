"""UVT Main"""

from pathlib import Path
import flet as ft  # type: ignore
from assets.app_colors import AppColors
from views import flet_easy as fs  # type: ignore

app = fs.FletEasy(
    route_init="/home",
    path_views=Path(__file__).parent / "views",
)


@app.view
def view(data: fs.Datasy):
    """Main View"""
    return fs.Viewsy(
        appbar=ft.AppBar(
            title=ft.Text("UVT", color=ft.Colors.WHITE),
            center_title=True,
            bgcolor=ft.Colors.ON_SURFACE_VARIANT,
            color=ft.Colors.WHITE,
            actions=[
                ft.PopupMenuButton(
                    icon=ft.Icons.MENU,
                    icon_color=ft.Colors.WHITE,
                    items=[
                        ft.PopupMenuItem(
                            content="Home", on_click=lambda e: data.page.go(data.route_init)
                        ),
                        ft.PopupMenuItem(
                            content="RJ45 Wiring Scheme", on_click=lambda e: data.page.go("/rj45_scheme")
                        ),
                        ft.PopupMenuItem(
                            content="Copper Color Code", on_click=lambda e: data.page.go("/copper/color_code")
                        ),
                        ft.PopupMenuItem(
                            content="Fiber Color Code", on_click=lambda e: data.page.go("/fiber_color_code")
                        ),
                        ft.PopupMenuItem(
                            content="Static IP Instructions", on_click=lambda e: data.page.go("/uv/statics")
                        ),
                        ft.PopupMenuItem(
                            content="Copper Pair Calculator", on_click=lambda e: data.page.go("/copper/pair_to_color")
                        ),
                        ft.PopupMenuItem(
                            content="Distance Calculator", on_click=lambda e: data.page.go("/distance_calc")
                        ),
                    ]
                ),
            ],
        ),
        vertical_alignment="center",
        horizontal_alignment="center",
        bgcolor=AppColors.BG
    )


app.run()
