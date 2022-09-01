//
//  CopperPairCalc.swift
//  UVT
//
//  Created by Justin Kumpe on 8/22/22.
//

import Foundation
import UIKit
import KumpeHelpers
import DeviceKit

class CopperPairCalcViewController: UIViewController {

    // MARK: Parameters
    var labelPairInfo = UILabel()
    var fieldPair = UITextField()
    var pairView = UIImageView()
    var binderView = UIView()
    var superBinderView = UIView()
    var buttonSubmit = UIButton()
    lazy var gradientPair: CAGradientLayer = {
        let gradient = CAGradientLayer()
        var pair = CopperPair.init(pair: 1)
        gradient.type = .conic
        gradient.colors = [
            pair.tipColor.cgColor,
            pair.ringColor.cgColor
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
    lazy var gradientBinder: CAGradientLayer = {
        let gradient = CAGradientLayer()
        var pair = CopperPair.init(pair: 1)
        gradient.type = .conic
        gradient.colors = [
            pair.tipColor.cgColor,
            pair.ringColor.cgColor
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
    var gradientSuperBinder = CAGradientLayer()

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        buildFieldPair()
        buildSubmitButton()
        buildPairInfo()
    }

    // MARK: buildSubmitButton
    func buildSubmitButton() {
        buttonSubmit = {
            let button = UIButton()
            button.addTarget(self, action: #selector(submitPair), for: .touchUpInside)
            button.backgroundColor = .gray
            button.layer.cornerRadius = 5
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Submit", for: .normal)
            button.tag = 1
            return button
        }()
        view.addSubview(buttonSubmit)
        buttonSubmit.topAnchor.constraint(equalTo: fieldPair.bottomAnchor, constant: 15).isActive = true
        buttonSubmit.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonSubmit.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    // MARK: buildFieldPair
    func buildFieldPair() {
        fieldPair = {
            let field = UITextField()
            field.translatesAutoresizingMaskIntoConstraints = false
            field.attributedPlaceholder = NSAttributedString(
                string: "Pair #",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
            field.keyboardType = .numberPad
            field.borderStyle = .roundedRect
            field.textAlignment = .center
            field.backgroundColor = .white
            field.textColor = .black
            field.clearsOnInsertion = true
            field.addTarget(self, action: #selector(submitPair), for: .primaryActionTriggered)
            field.addTarget(self, action: #selector(submitPair), for: .editingDidEnd)
            return field
        }()
        view.addSubview(fieldPair)
        fieldPair.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        fieldPair.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        fieldPair.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }

    // MARK: buildPairInfo
    func buildPairInfo(_ text: String = "Please enter pair number then hit enter/search") {
        labelPairInfo = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = -1
            label.text = text
            label.textAlignment = .center
            label.textColor = .white
            return label
        }()
        view.addSubview(labelPairInfo)
        labelPairInfo.topAnchor.constraint(equalTo: buttonSubmit.bottomAnchor, constant: 5).isActive = true
        labelPairInfo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        labelPairInfo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        labelPairInfo.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    // MARK: submitPair
    @objc func submitPair() {
        superBinderView.removeFromSuperview()
        binderView.removeFromSuperview()
        pairView.removeFromSuperview()
        guard let pairNumber = Int(fieldPair.text!) else {
            buildPairInfo()
            return
        }
        guard pairNumber < 15626, pairNumber > 0 else {
            KumpeHelpers.ShowAlert.centerView(theme: .error, title: "Error", message: "Please enter a pair number from 1 thru 15625", seconds: 10, invokeHaptics: true)
            return
        }
        let pair = CopperPair.init(pair: pairNumber)
        labelPairInfo.text = "Pair: \(pair.basePair!) (\(pair.tip!)\\\(pair.ring!))\nBinder: \(pair.binder!) (\(pair.binderTip!)\\\(pair.binderRing!))\nSuper Binder: \(pair.superBinder!) (\(pair.superBinderTip!)\\\(pair.superBinderRing!))"
        buildSuperBinderView(pair)
        buildBinderView(pair)
        buildPairView(pair)
        self.view.endEditing(true)
    }

    // MARK: buildSuperBinderView
    func buildSuperBinderView(_ pair: CopperPair) {
        guard !UIDevice.current.orientation.isLandscape || Device.current.isPad else {
            superBinderView.isHidden = true
            return
        }
        superBinderView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            view.isHidden = false
            return view
        }()
        view.addSubview(superBinderView)
        superBinderView.topAnchor.constraint(equalTo: labelPairInfo.bottomAnchor).isActive = true
        superBinderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        superBinderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        superBinderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        if pair.superBinder! == 1 {
            superBinderView.isHidden = true
        }
        gradientSuperBinder = {
            let gradient = CAGradientLayer()
            gradient.type = .conic
            gradient.colors = [
                pair.superBinderTipColor.cgColor,
                pair.superBinderRingColor.cgColor
            ]
            gradient.locations = [0, 1]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
            return gradient
        }()
        superBinderView.layer.insertSublayer(gradientSuperBinder, at: 0)
        gradientSuperBinder.frame = superBinderView.bounds
    }

    // MARK: buildBinderView
    func buildBinderView(_ pair: CopperPair) {
        guard !UIDevice.current.orientation.isLandscape || Device.current.isPad else {
            binderView.isHidden = true
            return
        }
        binderView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            view.isHidden = false
            return view
        }()
        binderView.isHidden = false
        view.addSubview(binderView)
        binderView.topAnchor.constraint(equalTo: superBinderView.topAnchor, constant: 50).isActive = true
        binderView.trailingAnchor.constraint(equalTo: superBinderView.trailingAnchor, constant: -50).isActive = true
        binderView.leadingAnchor.constraint(equalTo: superBinderView.leadingAnchor, constant: 50).isActive = true
        binderView.bottomAnchor.constraint(equalTo: superBinderView.bottomAnchor, constant: -50).isActive = true

        gradientBinder = {
            let gradient = CAGradientLayer()
            gradient.type = .conic
            gradient.colors = [
                pair.binderTipColor.cgColor,
                pair.binderRingColor.cgColor
            ]
            gradient.locations = [0, 1]
            gradient.startPoint = CGPoint(x: 1, y: 1)
            gradient.endPoint = CGPoint(x: 0, y: 0)
            return gradient
        }()
        binderView.layer.insertSublayer(gradientBinder, at: 0)
    }

    // MARK: buildPairView
    func buildPairView(_ pair: CopperPair) {
        guard !UIDevice.current.orientation.isLandscape || Device.current.isPad else {
            pairView.isHidden = true
            return
        }
        pairView = {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear
            view.isHidden = false
            return view
        }()
        view.addSubview(pairView)
        pairView.topAnchor.constraint(equalTo: binderView.topAnchor, constant: 50).isActive = true
        pairView.trailingAnchor.constraint(equalTo: binderView.trailingAnchor, constant: -50).isActive = true
        pairView.leadingAnchor.constraint(equalTo: binderView.leadingAnchor, constant: 50).isActive = true
        pairView.bottomAnchor.constraint(equalTo: binderView.bottomAnchor, constant: -50).isActive = true
        gradientPair = {
            let gradient = CAGradientLayer()
            gradient.type = .conic
            gradient.colors = [
                pair.tipColor.cgColor,
                pair.ringColor.cgColor
            ]
            gradient.locations = [0, 1]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
            return gradient
        }()
        pairView.image = UIImage(named: "Pair \(pair.basePair!)")
    }

    // MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        gradientSuperBinder.frame = superBinderView.bounds
        gradientBinder.frame = binderView.bounds
        gradientPair.frame = pairView.bounds
    }

    // MARK: viewWillTransistion
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        submitPair()
    }

    // MARK: Hide Keyboard
    // Hides Keyboard when user touches outside of text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
