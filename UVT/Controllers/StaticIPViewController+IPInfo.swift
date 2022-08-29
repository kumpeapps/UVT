//
//  StaticIPViewController+IPInfo.swift
//  UVT
//
//  Created by Justin Kumpe on 7/29/22.
//

import UIKit
import KumpeHelpers

extension StaticIPViewController {
    // MARK: buildIPInfo
    func buildIPInfo(_ build: Bool = true) {
        ipInfoText = "First Usable: \(ipInfo!.firstUsable.string)\nLast Usable: \(ipInfo!.lastUsable.string)\nRG/Default Gateway: \(ipInfo!.defaultGateway.string)\nSubnet Mask: \(ipInfo!.subnetMask)\nPrimary DNS: \(ipInfo!.attPrimaryDNS)\nSecondary DNS: \(ipInfo!.attSecondaryDNS)"
        buildIPInfoText(build)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareInfo(sender:)))
        buildARRISInsButton(build)
        buildPACEInsButton(build)
        if !build {
            navigationItem.rightBarButtonItem = nil
        }
    }

    // MARK: buildIPInfoText
    func buildIPInfoText(_ build: Bool = true) {
        guard build else {
            self.labelText.removeFromSuperview()
            return
        }
        self.labelText = {
            let text = UILabel()
            text.translatesAutoresizingMaskIntoConstraints = false
            text.font = UIFont(name: "Helevectia", size: 19)
            text.numberOfLines = -1
            text.textAlignment = .center
            text.text = ipInfoText
            text.textColor = .white
            return text
        }()
        scrollingView.addSubview(self.labelText)
        labelText.topAnchor.constraint(equalTo: scrollingView.topAnchor).isActive = true
        labelText.centerXAnchor.constraint(equalTo: scrollingView.centerXAnchor).isActive = true
        labelText.leadingAnchor.constraint(greaterThanOrEqualTo: scrollingView.leadingAnchor).isActive = true
        labelText.trailingAnchor.constraint(lessThanOrEqualTo: scrollingView.trailingAnchor).isActive = true
    }

    // MARK: shareInfo
    @objc func shareInfo(sender: UIBarButtonItem) {
        if instructions == "" {
            KumpeHelpers.Share.text("Static IP Information\n\(ipInfoText)", self, shareButton: navigationItem.rightBarButtonItem!)
        } else {
            KumpeHelpers.Share.text("Static IP Information\n\(ipInfoText)\n\n\(instructions)", self, shareButton: navigationItem.rightBarButtonItem!)
        }
    }

    // MARK: buildARRISInsButton
    func buildARRISInsButton(_ build: Bool = true) {
        guard build else {
            buttonARRISIns.removeFromSuperview()
            return
        }
        buttonARRISIns = {
            let button = UIButton()
            button.addTarget(self, action: #selector(buildAARIS(sender:)), for: .touchUpInside)
            button.backgroundColor = .gray
            button.layer.cornerRadius = 5
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("AARIS RG Instructions", for: .normal)
            button.tag = 1
            return button
        }()
        scrollingView.addSubview(buttonARRISIns)
        buttonARRISIns.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 40).isActive = true
        buttonARRISIns.centerXAnchor.constraint(equalTo: scrollingView.centerXAnchor).isActive = true
        buttonARRISIns.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    // MARK: buildARRISInsButton
    func buildPACEInsButton(_ build: Bool = true) {
        guard build else {
            buttonPACEIns.removeFromSuperview()
            return
        }
        buttonPACEIns = {
            let button = UIButton()
            button.addTarget(self, action: #selector(buildPACE(sender:)), for: .touchUpInside)
            button.backgroundColor = .gray
            button.layer.cornerRadius = 5
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("PACE RG Instructions", for: .normal)
            button.tag = 1
            return button
        }()
        scrollingView.addSubview(buttonPACEIns)
        buttonPACEIns.topAnchor.constraint(equalTo: buttonARRISIns.bottomAnchor, constant: 15).isActive = true
        buttonPACEIns.bottomAnchor.constraint(equalTo: scrollingView.bottomAnchor).isActive = true
        buttonPACEIns.centerXAnchor.constraint(equalTo: scrollingView.centerXAnchor).isActive = true
        buttonPACEIns.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

}
