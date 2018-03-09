//
//  LoginSDKController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/9/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import FBSDKLoginKit

final class LoginSDKController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 100, width: view.frame.width / 2 + 40 , height: 50)
        loginButton.delegate = self
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of FaceBook")
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("Error:  \(error.localizedDescription)")
            return
        }

        print("Successfully logged in with faceBook...")
    }
}
