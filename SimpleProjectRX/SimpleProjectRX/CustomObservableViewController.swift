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
    var photo: UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Custom Observable"
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.pushAlbumViewController))
        chooseImageLabel.isUserInteractionEnabled = true
        chooseImageLabel.addGestureRecognizer(gesture)

        saveImageButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                guard let this = self else { return }
                this.savePhoto()
            }).addDisposableTo(bag)

        clearButton()

    }

    private func clearButton() {
        clearImageButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.imageView.image = nil
                this.photo = nil
            }).addDisposableTo(bag)
    }

    private func savePhoto() {
        guard let photo = self.photo else {
            showAlert(message: "Please choose photo to save.")
            return
        }

        PhotoWriter.save(photo)
            .subscribe(
                onError: { [weak self] (error) in
                    guard let this = self else { return }
                    this.showAlert(message: "error: \(error.localizedDescription)")
                },
                onCompleted: { [weak self] in
                    guard let this = self else { return }
                    this.showAlert(message: "Saved!")
            })
            .disposed(by: PhotoWriter.bag)
    }

    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Rx swift", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Private Func
    @objc private func pushAlbumViewController() {
        let albumViewController = AlbumViewController()
        albumViewController.selectedImage.asObservable()
            .subscribe(onNext: { [weak self] NewImage in
                guard let this = self else { return }
                this.photo = NewImage
                this.imageView.image = NewImage
            }).addDisposableTo(albumViewController.bag)
        navigationController?.pushViewController(albumViewController, animated: true)
    }
}
