//
//  StaticIPViewController+Ins.swift
//  UVT
//
//  Created by Justin Kumpe on 7/29/22.
//

import UIKit
import KumpeHelpers

extension StaticIPViewController {

    // MARK: buildAARIS
    @objc func buildAARIS(sender: UIButton) {
        instructions = "AARIS Gateway Instructions\n\n1. Goto the RG configuration Page (192.168.1.254)\n\n2. Click Home Network\n\n3. Click Subnets & DHCP\n\n4. Set Public Subnet Enable to On\n\n5. In public IPv4 Address Field Enter \(ipInfo!.defaultGateway.string)\n\n6. In the Public Subnet mask Enter \(ipInfo!.subnetMask)\n\n7. In the Public DHCPv4 Start Address Field Enter \(ipInfo!.firstUsable.string)\n\n8. In the Public DHCPv4 End Address Field Enter \(ipInfo!.lastUsable.string)\n\n9. Set Allow Inbound Traffic to On\n\n10. Set Primary DHCP Pool to Private\n\n11. Click Save"
        labelText.text = instructions
        scrollingView.setContentOffset(.zero, animated: true)
    }

    // MARK: buildPACE
    @objc func buildPACE(sender: UIButton) {
        instructions = "PACE Gateway Instructions\n\n1. Goto the RG configuration Page (192.168.1.254)\n\n2. Click Settings\n\n3.Click Broadband\n\n4. Click Link Configuration\n\n5. Scroll to Supplementary Network\n\n6. Select Add Additional Network\n\n7. In the Router Address field enter \(self.ipInfo!.defaultGateway.string)\n\n8. In the subnet mask field enter \(self.ipInfo!.subnetMask)\n\n9. Check Auto Firewall Open\n\n10. Click Save"
        labelText.text = instructions
        scrollingView.setContentOffset(.zero, animated: true)
    }

}
