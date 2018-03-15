//
//  LoginCell.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/14/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {

    let imageName: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "logo")
        return iv
    }()

    let emailTextField: LeftPaddedTextFiled = {
        let textField = LeftPaddedTextFiled()
        textField.placeholder = "Enter email"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        return textField
    }()

    let passwordTextField: LeftPaddedTextFiled = {
        let textField = LeftPaddedTextFiled()
        textField.placeholder = "Enter password"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        return textField
    }()

    lazy var buttonLogin: UIButton = {
        let bt = UIButton(type: .system)
        bt.backgroundColor = .orange
        bt.setTitle("Log in", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return bt
    }()

    lazy var buttonLogout: UIButton = {
        let bt = UIButton(type: .system)
        bt.backgroundColor = .orange
        bt.setTitle("Log out", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return bt
    }()

    weak var delegate: LoginWalkthroughDelegate?


    @objc private func handleLogout() {
        self.delegate?.finishlogOut()
    }

    @objc private func handleLogin() {
        self.delegate?.finishLoggingIn()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageName)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(buttonLogin)
        addSubview(buttonLogout)

        imageName.anchor(top: centerYAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: -230, left: 0, bottom: 0, right: 0), size: .init(width: 160, height: 160))
        imageName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        emailTextField.anchor(top: imageName.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 32, bottom: 0, right: 32), size: .init(width: 0, height: 50))

        passwordTextField.anchor(top: emailTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 32, bottom: 0, right: 32), size: .init(width: 0, height: 50))

        buttonLogin.anchor(top: passwordTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 32, bottom: 0, right: 32), size: .init(width: 0, height: 50))

        buttonLogout.anchor(top: buttonLogin.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 32, bottom: 0, right: 32), size: .init(width: 0, height: 50))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LeftPaddedTextFiled: UITextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
}
