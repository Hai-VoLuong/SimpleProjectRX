//
//  LoginSDKController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/9/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

final class LoginSDKController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 100, width: view.frame.width / 2 + 40 , height: 50)
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]

        // add custom login facebook
        let customFBButton = UIButton(type: .system)
        customFBButton.backgroundColor = .blue
        customFBButton.frame = CGRect(x: 16, y: 160, width: view.frame.width / 2 + 40 , height: 50)
        customFBButton.setTitle("Custom FB Login here", for: .normal)
        customFBButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        customFBButton.setTitleColor(.white, for: .normal)
        customFBButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
        view.addSubview(customFBButton)
    }

    fileprivate func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}

extension LoginSDKController: FBSDKLoginButtonDelegate {

    @objc fileprivate func handleCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) {[weak self] (result, error) in
            guard let this = self else { return }
            if error != nil {
                print("Custom FB Login Failed: ", error ?? "")
                return
            }
            this.showEmailAddress()
        }
    }


    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of FaceBook")
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("Error:  \(error.localizedDescription)")
            return
        }

        showEmailAddress()
    }

    fileprivate func showEmailAddress() {

        // login Firebase with user facebook
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }

        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("Something went wrong with our FB user: ", error ?? "")
                return
            }

            print("Successfully logged in with our user: ", user?.email ?? "")
        })

        // get infor user from facebook
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, link, first_name, last_name, picture.type(large), email"]).start { (connection, result, error) in
            if error != nil {
                print("Failed to start graph request: ", error ?? "")
                return
            }
            if let result = result as? [String: Any]  {
                let user = result["email"] as! String
                self.presentAlert(message: user)
            }
        }
    }
}
