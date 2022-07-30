//
//  StaticIPViewController.swift
//  UVT
//
//  Created by Justin Kumpe on 7/28/22.
//

import UIKit
import KumpeHelpers

class StaticIPViewController: UIViewController {

    // MARK: labels
    var labelTitle = UILabel()
    var labelText = UILabel()

    // MARK: fields
    var fieldStartIP = UITextField()
    var fieldBlockSize = UITextField()

    // MARK: buttons
    var buttonSubmit = UIButton()
    var buttonARRISIns = UIButton()
    var buttonPACEIns = UIButton()

    // MARK: parameters
    var ipInfo: IPInfo?
    var startIP: IPAddress?
    var ipInfoText = ""
    var instructions = ""

    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buildMain()
    }

}
