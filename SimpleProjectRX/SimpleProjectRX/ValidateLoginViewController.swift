//
//  ValidateLoginViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/2/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MVVM

final class ValidateLoginViewController: UIViewController, MVVM.View {

    // MARK: - IBoutlets
    @IBOutlet private weak var usernameTextFiled: UITextField!
    @IBOutlet private weak var passwordTextFiled: UITextField!

    @IBOutlet private weak var validateUserNameLabel: UILabel!
    @IBOutlet private weak var validatePasswordLabel: UILabel!

    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var showPasswordSwitch: UISwitch!

    // MARK: - Properties
    var viewModel: LoginViewModel!
    let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "validate login"
        validateUserNameLabel.text = "User name has least \(Validation.minimumUserNameLength) character"
        validatePasswordLabel.text = "User name has least \(Validation.minimumPasswordLength) character"

        updateView()
    }

    // MARK: - Private func
    internal func updateView() {
        setupModel()
        setupObservable()
    }

    private func setupModel() {
        viewModel = LoginViewModel(input: (userName: usernameTextFiled.rx.text.orEmpty,
                                           password: passwordTextFiled.rx.text.orEmpty,
                                           logintap: loginButton.rx.tap.asObservable()))
    }

    private func setupObservable() {
        // if character validatedUserName > 5 thì validateUserNameLabel ẩn đi
        viewModel.validatedUserName
            .bind(to: validateUserNameLabel.rx.isHidden)
            .disposed(by: disposeBag)

        // if validatedUserName < 5 thì passwordTextFiled không dc mở
        viewModel.validatedUserName
            .bind(to: passwordTextFiled.rx.isEnabled)
            .disposed(by: disposeBag)

        // if character validatedPassword > 5 thì validatePasswordLabel ẩn đi
        viewModel.validatedPassword
            .bind(to: validatePasswordLabel.rx.isHidden)
            .disposed(by: disposeBag)

        // if validatedPassword false thì showPasswordSwitch không dc mở
        viewModel.validatedPassword
            .bind(to: showPasswordSwitch.rx.isEnabled)
            .disposed(by: disposeBag)

        viewModel.loginEnabled
            .bind { [weak self] valid in
                guard let this = self else { return }
                this.loginButton.isEnabled = valid
                this.loginButton.alpha = valid ? 1 : 0.5
            }
            .disposed(by: disposeBag)

        showPasswordSwitch.rx.isOn
            .subscribe(onNext: { [weak self] isOn in
                guard let this = self else { return }
                this.passwordTextFiled.isSecureTextEntry = !isOn
            })
            .disposed(by: disposeBag)

        viewModel.loginObservable
            .bind { [weak self] user, error in
                guard let this = self else { return }
                if let error = error {
                    this.showAlert(message: error.localizedDescription)
                } else {
                    this.showAlert(message: user.name)
                }
            }
            .disposed(by: disposeBag)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "demo Rx", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}















