//
//  ChatController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/21/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class ChatFirebaseController: UIViewController {

    let inputContainView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 5
        v.layer.masksToBounds = true
        return v
    }()

    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        return tf
    }()

    let nameSeparatorView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        return v
    }()

    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        return tf
    }()

    let emailSeparatorView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        return v
    }()

    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        return tf
    }()

    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "gameofthrones")
        iv.contentMode = .scaleAspectFill
        return iv
    }()

    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.masksToBounds = true
        return button
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "chat Firebase"
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)

        view.addSubview(profileImageView)
        view.addSubview(inputContainView)
        view.addSubview(loginRegisterButton)

        setupProfileImageview()
        setupInputsContainerView()
        setupLoginRegisterButton()
    }

    // ep2: 11'13
    fileprivate func setupProfileImageview() {
        profileImageView.anchor(top: view.centerYAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: -250, left: 12, bottom: 0, right: 12), size: .init(width: 150, height: 150))
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    fileprivate func setupInputsContainerView() {
        inputContainView.anchor(top: profileImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 200))
        inputContainView.addSubview(nameTextField)
        inputContainView.addSubview(nameSeparatorView)
        inputContainView.addSubview(emailTextField)
        inputContainView.addSubview(emailSeparatorView)
        inputContainView.addSubview(passwordTextField)


        nameTextField.anchor(top: inputContainView.topAnchor, leading: inputContainView.leadingAnchor, bottom: nil, trailing: inputContainView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12), size: .init(width: 0, height: 50))

        nameSeparatorView.anchor(top: nameTextField.bottomAnchor, leading: inputContainView.leadingAnchor, bottom: nil, trailing: inputContainView.trailingAnchor, padding: .zero, size: .init(width: 0, height: 1))

        emailTextField.anchor(top: nameSeparatorView.bottomAnchor, leading: inputContainView.leadingAnchor, bottom: nil, trailing: inputContainView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12), size: .init(width: 0, height: 50))

        emailSeparatorView.anchor(top: emailTextField.bottomAnchor, leading: inputContainView.leadingAnchor, bottom: nil, trailing: inputContainView.trailingAnchor, padding: .zero, size: .init(width: 0, height: 1))

        passwordTextField.anchor(top: emailSeparatorView.bottomAnchor, leading: inputContainView.leadingAnchor, bottom: nil, trailing: inputContainView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 50))

    }

    fileprivate func setupLoginRegisterButton() {
        loginRegisterButton.anchor(top: inputContainView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 30))
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue:b/255, alpha: 1)
    }
}
