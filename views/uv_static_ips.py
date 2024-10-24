"""UVT Home"""

import flet as ft  # type: ignore
import flet_easy as fs  # type: ignore
from assets.app_colors import AppColors
from classes.IP import IP

statics = fs.AddPagesy(route_prefix="/uv/statics")


@statics.page("/", title="Static IP Instructions", share_data=True, page_clear=True)
def statics_page(data: fs.Datasy):
    """Static IP Page"""

    def submit():
        """Submit"""
        data.share.set("ip_network", IP.Network(ip_field.value, block_size_field.value))
        data.page.go("/uv/statics/info")

    view = data.view
    title = ft.Text(
        value="Static IP Instructions",
        text_align=ft.alignment.center,
        color=ft.colors.WHITE,
    )
    ip_field = ft.TextField(
        text_align=ft.TextAlign.CENTER,
        max_length=15,
        keyboard_type=ft.KeyboardType.NUMBER,
        autofocus=True,
        helper_text="Start IP Address",
        color=ft.colors.WHITE,
        border_color=ft.colors.WHITE,
    )
    block_size_field = ft.Dropdown(
        options=[
            ft.dropdown.Option(8, alignment=ft.alignment.center),
            ft.dropdown.Option(16, alignment=ft.alignment.center),
            ft.dropdown.Option(32, alignment=ft.alignment.center),
            ft.dropdown.Option(64, alignment=ft.alignment.center),
        ],
        helper_text="Block Size",
        value=8,
        alignment=ft.alignment.center,
        color=ft.colors.WHITE,
    )
    submit_button = ft.ElevatedButton(text="Submit", on_click=lambda e: submit())
    container = ft.Container(
        bgcolor=AppColors.BG,
        # border_radius=35,
        # width=400,
        # height=850,
        content=ft.Stack(controls=[ft.Column(controls=[ip_field, block_size_field])]),
        # padding=50,
        alignment=ft.alignment.top_center,
    )

    return ft.View(
        controls=[title, container, submit_button],
        vertical_alignment="center",
        horizontal_alignment="center",
        appbar=view.appbar,
        bgcolor=AppColors.BG,
    )


@statics.page("/info", title="Static IP Instructions", share_data=True, page_clear=True)
def statics_info_page(data: fs.Datasy):
    """Static IP Info Page"""
    ip_network: IP.Network
    if data.share.contains_key("ip_network"):
        ip_network = data.share.get("ip_network")
    else:
        data.page.go("/uv/statics")

    def submit_aaris():
        """Get AARIS RG Instructions"""
        data.share.set("ip_network", ip_network)
        data.page.go("/uv/statics/aaris")

    def submit_pace():
        """Get PACE RG Instructions"""
        data.share.set("ip_network", ip_network)
        data.page.go("/uv/statics/pace")

    view = data.view
    title = ft.Text(
        value="Uverse Static IP Instructions",
        text_align=ft.alignment.center,
        color=ft.colors.WHITE,
    )
    statics_info = ft.Text(
        (
            f"First Usable: {ip_network.first_usable}\n"
            f"Last Usable: {ip_network.last_usable}\n"
            f"RG/Default Gateway: {ip_network.default_gateway}\n"
            f"Subnet Mask: {ip_network.subnet_mask}\n"
            f"Primary DNS: {ip_network.att_primary_dns}\n"
            f"Secondary DNS: {ip_network.att_secondary_dns}"
        ),
        text_align=ft.alignment.center,
        color=ft.colors.WHITE,
    )
    aaris = ft.ElevatedButton(
        text="AARIS RG Instructions", on_click=lambda e: submit_aaris()
    )
    pace = ft.ElevatedButton(
        text="PACE RG Instructions", on_click=lambda e: submit_pace()
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
                        statics_info,
                    ]
                )
            ]
        ),
        # padding=50,
        alignment=ft.alignment.top_center,
    )

    return ft.View(
        controls=[title, container, aaris, pace],
        vertical_alignment="center",
        horizontal_alignment="center",
        appbar=view.appbar,
        bgcolor=AppColors.BG,
    )


@statics.page("/aaris", title="Static IP Instructions", share_data=True, page_clear=True)
def statics_info_aaris_page(data: fs.Datasy):
    """Static IP Info AARIS Page"""
    ip_network: IP.Network
    if data.share.contains_key("ip_network"):
        ip_network = data.share.get("ip_network")
    else:
        data.page.go("/uv/statics")

    def submit_pace():
        """Get PACE RG Instructions"""
        data.share.set("ip_network", ip_network)
        data.page.go("/uv/statics/pace")

    view = data.view
    title = ft.Text(
        value="Uverse Static IP Instructions\nAARIS Gateway Instructions",
        text_align=ft.alignment.center,
        color=ft.colors.WHITE,
    )
    statics_info = ft.Text(
        (
            "1. Goto the RG configuration page (192.168.1.254)\n"
            "2. Click Home Network\n"
            "3. Click Subnets & DHCP\n"
            "4. Set Public Subnet Enable to ON\n"
            f"5. In Public IPv4 Address Field Enter {ip_network.default_gateway}\n"
            f"6. In the Public Subnet Mask Enter {ip_network.subnet_mask}\n"
            f"7. In the Public DHCPv4 Start Address Field Enter {ip_network.first_usable}\n"
            f"8. In the Public DHCPv4 End Address Field enter {ip_network.last_usable}\n"
            "9. Set Allow Inbound Traffic to On\n"
            "10 Set Primary DHCP Pool to Private\n"
            "11. Click Save"
        ),
        text_align=ft.alignment.center,
        color=ft.colors.WHITE,
    )
    pace = ft.ElevatedButton(
        text="PACE RG Instructions", on_click=lambda e: submit_pace()
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
                        statics_info,
                    ]
                )
            ]
        ),
        # padding=50,
        alignment=ft.alignment.top_center,
    )

    return ft.View(
        controls=[title, container, pace],
        vertical_alignment="center",
        horizontal_alignment="center",
        appbar=view.appbar,
        bgcolor=AppColors.BG,
    )


@statics.page("/pace", title="Static IP Instructions", share_data=True, page_clear=True)
def statics_info_pace_page(data: fs.Datasy):
    """Static IP Info PACE Page"""
    ip_network: IP.Network
    if data.share.contains_key("ip_network"):
        ip_network = data.share.get("ip_network")
    else:
        data.page.go("/uv/statics")

    def submit_aaris():
        """Get PACE AARIS Instructions"""
        data.share.set("ip_network", ip_network)
        data.page.go("/uv/statics/aaris")

    view = data.view
    title = ft.Text(
        value="Uverse Static IP Instructions\nPACE Gateway Instructions",
        text_align=ft.alignment.center,
        color=ft.colors.WHITE,
    )
    statics_info = ft.Text(
        (
            "1. Goto the RG configuration page (192.168.1.254)\n"
            "2. Click Settings\n"
            "3. Click Broadband\n"
            "4. Click Link Configuration\n"
            "5. Scroll to Supplementary Network\n"
            "6. Select Add Additional Network\n"
            f"7. In the Route Address field enter {ip_network.default_gateway}\n"
            f"8. In the subnet mask field enter {ip_network.subnet_mask}\n"
            "9. Check Auto Firewall Open"
            "10. Click Save"
        ),
        text_align=ft.alignment.center,
        color=ft.colors.WHITE,
    )
    pace = ft.ElevatedButton(
        text="AARIS RG Instructions", on_click=lambda e: submit_aaris()
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
                        statics_info,
                    ]
                )
            ]
        ),
        # padding=50,
        alignment=ft.alignment.top_center,
    )

    return ft.View(
        controls=[title, container, pace],
        vertical_alignment="center",
        horizontal_alignment="center",
        appbar=view.appbar,
        bgcolor=AppColors.BG,
    )
