//
//  CopperPairCalc.swift
//  UVT
//
//  Created by Justin Kumpe on 8/22/22.
//

import Foundation
import UIKit

class CopperPairCalcViewController: UIViewController {
    // MARK: Parameters
    var pair: CopperPair?
    var labelPairInfo = UILabel()
    var fieldPair = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildFieldPair()
        buildPairInfo()
    }

    func buildFieldPair() {
        fieldPair = {
            let field = UITextField()
            field.translatesAutoresizingMaskIntoConstraints = false
            field.attributedPlaceholder = NSAttributedString(
                string: "Pair #",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
            field.keyboardType = .decimalPad
            field.borderStyle = .roundedRect
            field.textAlignment = .center
            field.backgroundColor = .white
            field.textColor = .black
            field.clearsOnInsertion = true
            field.returnKeyType = .search
            //button.addTarget(self, action: #selector(buildPACE(sender:)), for: .touchUpInside)
            field.addTarget(self, action: #selector(submitPair), for: .primaryActionTriggered)
            field.addTarget(self, action: #selector(submitPair), for: .editingDidEnd)
            return field
        }()
        view.addSubview(fieldPair)
        fieldPair.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        fieldPair.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        fieldPair.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }

    func buildPairInfo(_ text: String = "Please enter pair number then hit enter/search") {
        labelPairInfo = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = -1
            label.text = text
            label.textAlignment = .center
            return label
        }()
        view.addSubview(labelPairInfo)
        labelPairInfo.topAnchor.constraint(equalTo: fieldPair.bottomAnchor, constant: 5).isActive = true
        labelPairInfo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        labelPairInfo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        labelPairInfo.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    @objc func submitPair() {
        guard let pairNumber = Int(fieldPair.text!) else {
            buildPairInfo()
            return
        }
        pair = CopperPair.init(pair: pairNumber)
        let binder = CopperPair.init(pair: pair!.binder)
        let superBinder = CopperPair.init(pair: pair!.superBinder)
        labelPairInfo.text = "Pair: \(pair!.pair!) (\(pair!.ring!)\\\(pair!.tip!))\nBinder: \(binder.pair!) (\(binder.ring!)\\\(binder.tip!))\nSuper Binder: \(superBinder.pair!) (\(superBinder.ring!)\\\(superBinder.tip!))"
    }
}
