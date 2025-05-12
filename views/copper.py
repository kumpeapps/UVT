"""UVT Home"""

import flet as ft  # type: ignore
import flet_easy as fs  # type: ignore
from assets.app_colors import AppColors
from classes.CopperPair import CopperPair

copper = fs.AddPagesy(route_prefix="/copper")


@copper.page("/color_code", title="Copper Color Code")
def copper_color_code_page(data: fs.Datasy):
    """RJ45 Scheme Page"""
    view = data.view
    image = ft.Image(src="/images/25-pair-color-code.png")
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
        bgcolor=AppColors.BG,
        scroll=ft.ScrollMode.ALWAYS,
    )


@copper.page("/pair_to_color", title="Copper Color To Pair")
def copper_pair_to_color_page(data: fs.Datasy):
    """Copper Pair to Color Page"""

    def changed_pair():
        """Changed Pair"""
        pair_data = CopperPair(int(pair_field.value))
        pair_info.value = (
            f"Pair: {pair_data.base_pair} ({pair_data.tip_color}/{pair_data.ring_color})\n"
            f"Binder: {pair_data.binder} ({pair_data.binder_tip_color}/{pair_data.binder_ring_color})\n"
            f"Super Binder: {pair_data.super_binder} ({pair_data.super_binder_tip_color}/{pair_data.super_binder_ring_color})\n"
        )
        data.page.update()

    view = data.view
    title = ft.Text(
        value="Copper Pair Calculator",
        text_align=ft.alignment.center,
        color=ft.Colors.WHITE,
    )
    pair_field = ft.TextField(
        text_align=ft.TextAlign.CENTER,
        keyboard_type=ft.KeyboardType.NUMBER,
        autofocus=True,
        helper_text="Pair Number",
        color=ft.Colors.WHITE,
        border_color=ft.Colors.WHITE,
        width=100,
        on_change=lambda e: changed_pair(),
    )

    pair_info = ft.Text(
        "",
        text_align=ft.alignment.center,
        color=ft.Colors.WHITE,
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
                    ]
                )
            ]
        ),
        # padding=50,
        alignment=ft.alignment.top_center,
    )

    return ft.View(
        controls=[title, container, pair_info],
        vertical_alignment="center",
        horizontal_alignment="center",
        appbar=view.appbar,
        bgcolor=AppColors.BG,
    )
