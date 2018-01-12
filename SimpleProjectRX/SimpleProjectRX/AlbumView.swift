//
//  AlbumView.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/11/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class AlbumView: UIView {

    private var coverImageView: UIImageView!
    private var indicatorView: UIActivityIndicatorView!

    // 6 Deisgn Pattern KVO Observing mechanism allows an object to observe changes to a property
    private var valueObservation: NSKeyValueObservation!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    init(frame: CGRect, coverUrl: String) {
        super.init(frame: frame)
        commonInit()
        // 1. This line sends a notification through the NotificationCenter singleton
        NotificationCenter.default.post(name: .BLDownloadImage, object: self, userInfo: ["imageView": coverImageView, "coverUrl": coverUrl])
    }

    private func commonInit() {
        // Setup the background
        backgroundColor = .black

        // Create the cover image view
        coverImageView = UIImageView()
        coverImageView.translatesAutoresizingMaskIntoConstraints = false

        // \.image a key path expression
        valueObservation = coverImageView.observe(\.image, options: [.new]) { [unowned self] observed, change in
            if change.newValue is UIImage {
                self.indicatorView.stopAnimating()
            }
        }

        addSubview(coverImageView)

        // Create the indicator view
        indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.activityIndicatorViewStyle = .whiteLarge
        indicatorView.startAnimating()
        addSubview(indicatorView)

        NSLayoutConstraint.activate([
            coverImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            coverImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),

            indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }

    func highlightAlbum(_ didHighlightView: Bool) {
        if didHighlightView == true {
            backgroundColor = .white
        } else {
            backgroundColor = .black
        }
    }

}

