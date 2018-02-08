//
//  TapViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/7/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift

final class TapViewController: UIViewController {

    @IBOutlet private weak var tapButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!

    var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tap"
        tapButton.rx.tap
            .asDriver()
            .do(onNext: {
                self.resultLabel.text = "tap..."
            })
            .debounce(0.5)
            .drive(onNext: {
                self.resultLabel.text = "result..."
            }).addDisposableTo(bag)

    }
}
