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
    image = ft.Image(src="../assets/25-pair-color-code.png")
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
        scroll=ft.ScrollMode.ALWAYS
    )

@copper.page("/pair_to_color/{pair}", title="Copper Color To Pair")
@copper.page("/pair_to_color", title="Copper Color To Pair")
def copper_pair_to_color_page(data: fs.Datasy, pair=""):
    """Copper Pair to Color Page"""
    def changed_pair():
        """Changed Pair"""
        data.page.go(f"/copper/pair_to_color/{pair_field.value}")
    view = data.view
    title = ft.Text(
        value="Copper Pair Calculator",
        text_align=ft.alignment.center,
        color=ft.colors.WHITE,
    )
    pair_field = ft.TextField(
        text_align=ft.TextAlign.CENTER,
        keyboard_type=ft.KeyboardType.NUMBER,
        autofocus=True,
        helper_text="Pair Number",
        color=ft.colors.WHITE,
        border_color=ft.colors.WHITE,
        width=100,
        value=pair,
        on_change=lambda e: changed_pair()
    )
    if pair == "":
        pair_info = ft.Text(
        (
            ""
        ),
        text_align=ft.alignment.center,
        color=ft.colors.WHITE,
        )
    else:
        pair_data = CopperPair(int(pair))
        pair_info = ft.Text(
            (
                f"Pair: {pair} ({pair_data.tip_color}/{pair_data.ring_color})\n"
                f"Binder: {pair_data.binder} ({pair_data.binder_tip_color}/{pair_data.binder_ring_color})\n"
                f"Super Binder: {pair_data.super_binder} ({pair_data.super_binder_tip_color}/{pair_data.super_binder_ring_color})\n"
            ),
            text_align=ft.alignment.center,
            color=ft.colors.WHITE,
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
    