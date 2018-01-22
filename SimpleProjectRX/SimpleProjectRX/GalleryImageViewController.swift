//
//  GalleryImageViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/2/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class GalleryImageViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!

    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "gallery image"
        segmentedControl.rx.selectedSegmentIndex
            .filter({[weak self] index in
                guard let this = self else { return false }
                return index < this.segmentedControl.numberOfSegments
            })
            .subscribe(onNext: { [weak self] index in
                guard let this = self else { return }
                this.imageView.contentMode = UIViewContentMode(rawValue: index) ?? .scaleToFill
            })
        .addDisposableTo(bag)
    }
}
