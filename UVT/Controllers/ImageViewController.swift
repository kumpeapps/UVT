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

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
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
    func buildImageView(_ build: Bool = true) {
        let topAnchor = imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let bottomAnchor = imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        let trailingAnchor = imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let leadingAnchor = imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        guard build else {
            topAnchor.isActive = false
            bottomAnchor.isActive = false
            trailingAnchor.isActive = false
            leadingAnchor.isActive = false
            imageView.removeFromSuperview()
            return
        }
        view.addSubview(imageView)
        topAnchor.isActive = true
        bottomAnchor.isActive = true
        trailingAnchor.isActive = true
        leadingAnchor.isActive = true
    }

}
