//
//  StaticIPViewController.swift
//  UVT
//
//  Created by Justin Kumpe on 7/28/22.
//

import UIKit

class StaticIPViewController: UIViewController {

    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buildMain()
    }

    // MARK: buildMain
    func buildMain() {
        buildTitle()
    }

    // MARK: buildTitle
    func buildTitle() {
        let labelTitle: UILabel = {
            let title = UILabel()
            title.translatesAutoresizingMaskIntoConstraints = false
            title.font = UIFont(name: "Marker Felt", size: 21)
            title.textColor = .black
            title.text = "Uverse Static IP Instructions"
            title.adjustsFontSizeToFitWidth = true
            return title
        }()
        view.addSubview(labelTitle)
        labelTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        labelTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        labelTitle.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        labelTitle.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
}
