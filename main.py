"""UVT Main"""

from pathlib import Path
import flet as ft  # type: ignore
import flet_easy as fs  # type: ignore
from assets.app_colors import AppColors

app = fs.FletEasy(
    route_init="/home",
    path_views=Path(__file__).parent / "views",
)


@app.view
def view(data: fs.Datasy):
    """Main View"""
    return fs.Viewsy(
        appbar=ft.AppBar(
            title=ft.Text("UVT"),
            center_title=True,
            bgcolor=ft.colors.SURFACE_VARIANT,
            actions=[
                ft.PopupMenuButton(
                    items=[
                        ft.PopupMenuItem(
                            text="Home", on_click=data.go(data.route_init)
                        ),
                        ft.PopupMenuItem(
                            text="RJ45 Wiring Scheme", on_click=data.go("/rj45_scheme")
                        ),
                        ft.PopupMenuItem(
                            text="Copper Color Code", on_click=data.go("/copper_color_code")
                        ),
                        ft.PopupMenuItem(
                            text="Fiber Color Code", on_click=data.go("/fiber_color_code")
                        ),
                        ft.PopupMenuItem(
                            text="Static IP Instructions", on_click=data.go("/uv/statics")
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
