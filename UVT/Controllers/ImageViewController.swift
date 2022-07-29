//
//  ImageViewController.swift
//  UVT
//
//  Created by Justin Kumpe on 7/27/22.
//

import Foundation
import UIKit
import Kingfisher
import KumpeHelpers

class ImageViewController: UIViewController {
    
    // MARK: Properties
    let imageCache = ImageCache(name: "imageCache")
    var imageUrl: URL!

    // MARK: imageView
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: Buttons
    let closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(pressedClose(sender:)), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
    }()

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        buildCloseButton()
        buildImageView()
    }

    // MARK: viewDidAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.kf.setImage(
            with: imageUrl,
            placeholder: UIImage(named: "icons8-loading"),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage,
                .cacheSerializer(FormatIndicatedCacheSerializer.png),
                .targetCache(imageCache)
                ])
        imageCache.diskStorage.config.expiration = .days(90)
        imageCache.memoryStorage.config.expiration = .days(90)
    }

    // MARK: buildImageView
    func buildImageView() {
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    }

    // MARK: buildCloseButton
    func buildCloseButton() {
        view.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        closeButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor).isActive = true
    }

    // MARK: pressedClose
    @objc func pressedClose(sender: UIButton!) {
        self.dismiss(animated: true)
    }
}
