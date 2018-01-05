//
//  passDataBackUsingProtocolViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/5/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SendBackData {
    func senDataToBack(value: String)
}

final class PassDataBackUsingProtocolViewController: UIViewController {

    //MARK: - IBoutlets
    @IBOutlet private weak var button: UIButton!

    //MARK: - Properties
    var disposeBag = DisposeBag()
    var delegate: SendBackData?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "pass Data Back Using Protocol"
        buttonClick()
    }

    //MARK: - Private Func
    private func buttonClick() {
        button.rx.tap
            .subscribe(onNext: {
                self.delegate?.senDataToBack(value: "Send data t back")
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
