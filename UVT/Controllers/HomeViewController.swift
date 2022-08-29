//
//  ViewController.swift
//  UVT
//
//  Created by Justin Kumpe on 7/24/22.
//

import UIKit
import KumpeHelpers
import ModulesVC
import WhatsNew

class HomeViewController: ModulesVC {

    // MARK: Parameters
    var settingsBundle = KModuleSettings()
    var reachable: ReachabilitySetup!

    // MARK: WhatsNew
    let whatsNew = WhatsNewViewController(items: [
        WhatsNewItem.text(title: "New Module", subtitle: "Added module for Copper Pair Calculator so you can get the pair colors by entering a pair number.")
    ])

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        cellBackgroundColor = .clear
        collectionViewBackgroundColor = .clear
        settingsBundle.alert.title = "Module Not Implemented!"
        settingsBundle.alert.message = "This module is still under development"
        settingsBundle.alert.theme = .warning
        reachable = ReachabilitySetup()
    }

    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let ethernetWiringScheme = KModule.init(title: "RJ45 Wiring Scheme", action: "[segue]segueEthernet", icon: UIImage(named: "icons8-swirl")!, remoteIconURL: Icons8.ethernet.urlString)
        let copperColorCode = KModule.init(title: "Copper Color Code", action: "[segue]segueCopperColors", icon: UIImage(named: "icons8-swirl")!, remoteIconURL: Icons8.colorPalette.urlString)
        let fiberColorCode = KModule.init(title: "Fiber Color Code", action: "[segue]segueFiberColors", icon: UIImage(named: "icons8-swirl")!, remoteIconURL: Icons8.colorPalette.urlString)
        let staticIPInstructions = buildModule(title: "UV Static IP Instructions", action: "[segue]segueStaticIP", icon: UIImage(named: "icons8-swirl")!, remoteIconURL: Icons8.ipv4.urlString, isEnabled: true, watermark: UIImage(named: "icons8-disabled"), settings: settingsBundle)
        let copperPairCalc = buildModule(title: "Copper Pair Calc", action: "[segue]segueCopperPairCalc", icon: UIImage(named: "icons8-swirl")!, remoteIconURL: Icons8.pantex.urlString, isEnabled: true, watermark: UIImage(named: "icons8-disabled"), settings: settingsBundle)
        modules = [ethernetWiringScheme, copperColorCode, fiberColorCode, staticIPInstructions, copperPairCalc]
        setupCollectionView()
    }

    // MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        whatsNew.presentIfNeeded(on: self)
    }

    // MARK: prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEthernet" {
            let segueVC = segue.destination as! ImageViewController
            segueVC.imageUrl = URL(string: "https://uvt.kumpeapps.com/Photos/rj45-wiring-schemes.png")
        } else if segue.identifier == "segueCopperColors" {
            let segueVC = segue.destination as! ImageViewController
            segueVC.imageUrl = URL(string: "https://uvt.kumpeapps.com/Photos/25-pair-color-code.png")
        } else if segue.identifier == "segueFiberColors" {
            let segueVC = segue.destination as! ImageViewController
            segueVC.imageUrl = URL(string: "https://uvt.kumpeapps.com/Photos/fiber_color-code.jpg")
        }
    }

}
