//
//  StaticIPViewController+Main.swift
//  UVT
//
//  Created by Justin Kumpe on 7/29/22.
//

import UIKit
import KumpeHelpers
import SwiftUI

extension StaticIPViewController {
    // MARK: buildMain
    func buildMain(_ build: Bool = true) {
        buildTitle()
        buildScrollView()
        buildIPFields(build)
        buildSubmitButton(build)
    }

    // MARK: buildScrollView
    func buildScrollView() {
        scrollingView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.isScrollEnabled = true
            scrollView.showsVerticalScrollIndicator = true
            return scrollView
        }()
        view.addSubview(scrollingView)
        scrollingView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 15).isActive = true
        scrollingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    // MARK: buildTitle
    func buildTitle(_ build: Bool = true) {
        guard build else {
            labelTitle.removeFromSuperview()
            return
        }
        labelTitle = {
            let title = UILabel()
            title.translatesAutoresizingMaskIntoConstraints = false
            title.font = UIFont(name: "Marker Felt", size: 21)
            title.textColor = .black
            title.text = "Uverse Static IP Instructions"
            title.adjustsFontSizeToFitWidth = true
            title.tag = 1
            return title
        }()
        view.addSubview(labelTitle)
        labelTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        labelTitle.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        labelTitle.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }

    // MARK: buildIPFields
    func buildIPFields(_ build: Bool = true) {
        guard build else {
            fieldStartIP.removeFromSuperview()
            fieldBlockSize.removeFromSuperview()
            return
        }
        fieldStartIP = {
            let field = UITextField()
            field.translatesAutoresizingMaskIntoConstraints = false
            field.attributedPlaceholder = NSAttributedString(
                string: "Start IP Address",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
            field.keyboardType = .decimalPad
            field.borderStyle = .roundedRect
            field.textAlignment = .center
            field.backgroundColor = .white
            field.textColor = .black
            field.clearsOnInsertion = true
            field.tag = 1
            return field
        }()
        fieldBlockSize = {
            let field = UITextField()
            field.translatesAutoresizingMaskIntoConstraints = false
            field.attributedPlaceholder = NSAttributedString(
                string: "Block Size",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
            field.keyboardType = .asciiCapableNumberPad
            field.borderStyle = .roundedRect
            field.textAlignment = .center
            field.backgroundColor = .white
            field.textColor = .black
            field.clearsOnInsertion = true
            field.tag = 1
            return field
        }()
        scrollingView.addSubview(fieldStartIP)
        fieldStartIP.topAnchor.constraint(equalTo: scrollingView.topAnchor, constant: 15).isActive = true
        fieldStartIP.centerXAnchor.constraint(equalTo: scrollingView.centerXAnchor).isActive = true
        fieldStartIP.widthAnchor.constraint(equalToConstant: 200).isActive = true
        scrollingView.addSubview(fieldBlockSize)
        fieldBlockSize.topAnchor.constraint(equalTo: fieldStartIP.bottomAnchor, constant: 5).isActive = true
        fieldBlockSize.centerXAnchor.constraint(equalTo: scrollingView.centerXAnchor).isActive = true
        fieldBlockSize.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    // MARK: buildSubmitButton
    func buildSubmitButton(_ build: Bool = true) {
        guard build else {
            buttonSubmit.removeFromSuperview()
            return
        }
        buttonSubmit = {
            let button = UIButton()
            button.addTarget(self, action: #selector(pressedSubmit(sender:)), for: .touchUpInside)
            button.backgroundColor = .gray
            button.layer.cornerRadius = 5
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Submit", for: .normal)
            button.tag = 1
            return button
        }()
        scrollingView.addSubview(buttonSubmit)
        buttonSubmit.topAnchor.constraint(equalTo: fieldBlockSize.bottomAnchor, constant: 40).isActive = true
        buttonSubmit.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        buttonSubmit.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    // MARK: pressedSubmit
    @objc func pressedSubmit(sender: UIButton!) {
        let blockSizes = [8, 16, 32, 64]
        guard let startIP = fieldStartIP.text, startIP != "" else {
            KumpeHelpers.ShowAlert.centerView(theme: .error, title: "Start IP Required", message: "Please enter start IP address", seconds: 5, invokeHaptics: true)
            return
        }
        guard let blockSize = Int(fieldBlockSize.text!), blockSizes.contains(blockSize) else {
            KumpeHelpers.ShowAlert.centerView(theme: .error, title: "Block Size Required", message: "Please enter a block size of 8, 16, 32, or 64", seconds: 5, invokeHaptics: true)
            return
        }
        let startIPComponents = startIP.components(separatedBy: ".")
        guard startIPComponents.count == 4, let o1 = Int(startIPComponents[0]), let o2 = Int(startIPComponents[1]), let o3 = Int(startIPComponents[2]), let o4 = Int(startIPComponents[3]) else {
            KumpeHelpers.ShowAlert.centerView(theme: .error, title: "Invalid Start IP", message: "Please enter a valid start IP address", seconds: 5, invokeHaptics: true)
            return
        }
        guard o1 != 127 && o1 >= 1 && o1 <= 223 && o2 >= 0 && o2 <= 255 && o3 >= 0 && o3 <= 255 && o4 >= 0 && o4 <= 254 else {
            KumpeHelpers.ShowAlert.centerView(theme: .error, title: "Invalid Start IP", message: "Please enter a valid start IP addresss", seconds: 5, invokeHaptics: true)
            return
        }
        self.startIP = IPAddress.init(firstOctet: o1, secondOctet: o2, thirdOctet: o3, fourthOctet: o4)
        self.ipInfo = IPInfo.init(startIP: self.startIP!, blockSize: blockSize)
        buildMain(false)
        buildIPInfo()
    }
}
