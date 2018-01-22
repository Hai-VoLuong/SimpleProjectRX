//
//  CustomObservableViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/2/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class CustomObservableViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var chooseImageLabel: UILabel!
    @IBOutlet private weak var saveImageLabel: UILabel!
    @IBOutlet private weak var clearImageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Custom Observable"
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.pushAlbumViewController))
        chooseImageLabel.isUserInteractionEnabled = true
        chooseImageLabel.addGestureRecognizer(gesture)
    }

    func pushAlbumViewController() {
        navigationController?.pushViewController(AlbumViewController(), animated: true)
    }
}
