//
//  SecondViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/5/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class SecondViewController: UIViewController, SendBackData {

    // MARK: - IBoutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var button: UIButton!

    // MARK: - Properties
    var disposeBag = DisposeBag()
    var valueSendFromPassDataViewController: String?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Second view controller"
        buttonClick()
    }

    override func viewDidAppear(_ animated: Bool) {
        if let value = valueSendFromPassDataViewController {
            titleLabel.text = value
        }
    }

    // MARK: - Private Func
    private func buttonClick() {
        button.rx.tap
            .subscribe(onNext: { data in
                let passDataViewController = PassDataBackUsingProtocolViewController()
                    passDataViewController.delegate = self
                    self.navigationController?.pushViewController(passDataViewController, animated: true)
            }).disposed(by: disposeBag)
    }

    // MARK: - Public Func
    func senDataToBack(value: String) {
        valueSendFromPassDataViewController = value
    }
}
