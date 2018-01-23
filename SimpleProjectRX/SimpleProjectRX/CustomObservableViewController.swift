//
//  CustomObservableViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/2/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CustomObservableViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var chooseImageLabel: UILabel!
    @IBOutlet private weak var saveImageButton: UIButton!
    @IBOutlet private weak var clearImageButton: UIButton!

    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Custom Observable"
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.pushAlbumViewController))
        chooseImageLabel.isUserInteractionEnabled = true
        chooseImageLabel.addGestureRecognizer(gesture)

        clearButton()
    }

    private func clearButton() {
        clearImageButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.imageView.image = nil
            }).addDisposableTo(bag)
    }

    // MARK: - Private Func
    @objc private func pushAlbumViewController() {
        let albumViewController = AlbumViewController()
        albumViewController.selectedImage.asObservable()
            .subscribe(onNext: { [weak self] NewImage in
                guard let this = self else { return }
                this.imageView.image = NewImage
            }).addDisposableTo(albumViewController.bag)
        navigationController?.pushViewController(albumViewController, animated: true)
    }
}
