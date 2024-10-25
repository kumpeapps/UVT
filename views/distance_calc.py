"""UVT Home"""

import flet as ft  # type: ignore
import flet_easy as fs  # type: ignore
from assets.app_colors import AppColors

copper = fs.AddPagesy()


@copper.page("/distance_calc", title="Distance Calculator")
def distance_calc_page(data: fs.Datasy):
    """Distance Calculator Page"""

    view = data.view
    title = ft.Text(
        value="Distance Calculator",
        text_align=ft.alignment.center,
        color=ft.colors.WHITE,
    )
    text = ft.Text("")
    conversion_units = ft.Dropdown(
        options=[
            ft.dropdown.Option("Miles to Feet", alignment=ft.alignment.center),
            ft.dropdown.Option("Feet to Miles", alignment=ft.alignment.center),
        ],
        value="Miles to Feet",
        alignment=ft.alignment.center,
        color=ft.colors.WHITE,
        width=100,
        on_change=lambda e: changed_value(),
    )

    def changed_value():
        """Changed Value"""
        units = float(pair_field.value)
        if conversion_units.value == "Miles to Feet":
            new_units = units * 5280
            text.value = f"{units} miles = {new_units} feet"
        else:
            new_units = units / 5280
            text.value = f"{units} feet = {new_units} miles"
        data.page.update()

    pair_field = ft.TextField(
        text_align=ft.TextAlign.CENTER,
        keyboard_type=ft.KeyboardType.NUMBER,
        autofocus=True,
        helper_text="Pair Number",
        color=ft.colors.WHITE,
        border_color=ft.colors.WHITE,
        width=100,
        on_change=lambda e: changed_value(),
    )

    container = ft.Container(
        bgcolor=AppColors.BG,
        # border_radius=35,
        # width=400,
        # height=850,
        content=ft.Stack(
            controls=[
                ft.Column(
                    controls=[
                        pair_field,
                        conversion_units,
                    ]
                )
            ]
        ),
        # padding=50,
        alignment=ft.alignment.top_center,
    )

    return ft.View(
        controls=[title, container, text],
        vertical_alignment="center",
        horizontal_alignment="center",
        appbar=view.appbar,
        bgcolor=AppColors.BG,
    )
