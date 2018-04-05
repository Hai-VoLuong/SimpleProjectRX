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
import GoogleSignIn
import LineSDK
import TwitterKit


final class LoginSDKController: UIViewController, GIDSignInUIDelegate {

    var apiClient: LineSDKAPI?

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupFacebookButton()
//        setupGoogleButton()
        setupLineButton()
        setupTwitterButton()
    }

    fileprivate func setupTwitterButton() {
        var logInButton = TWTRLogInButton()


        logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if let err = error {
                print("Failed to login via Twitter: ", err)
                return
            }

            print(session?.userName ?? "")
            guard let token = session?.authToken else { return }
            guard let secret = session?.authTokenSecret else { return }
            let credentials = TwitterAuthProvider.credential(withToken: token, secret: secret)
            Auth.auth().signIn(with: credentials, completion: { (user, error) in
                if let err = error {
                    self.presentAlert(message: "Failed to login to Firebase with Twitter: \(err.localizedDescription)")
                    return
                }
                self.presentAlert(message: "Successfully created a Firebase Twitter user:  \(user?.uid ?? "")")

            })
        })

        logInButton.frame = CGRect(x: 16, y: 550, width: view.frame.width / 2 + 50, height: 50)
        view.addSubview(logInButton)
    }

    fileprivate func setupGoogleButton() {
        // add sign in google
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 16, y: 220, width: view.frame.width / 2 + 50 , height: 50)
        view.addSubview(googleButton)

        //add custom sign in google
        let customGoogleButton = UIButton(type: .system)
        customGoogleButton.frame = CGRect(x: 16, y: 280, width: view.frame.width / 2 + 50 , height: 50)
        customGoogleButton.backgroundColor = .orange
        customGoogleButton.setTitle("Custom google sign in", for: .normal)
        customGoogleButton.addTarget(self, action: #selector(handleCustomGoogleSign), for: .touchUpInside)
        customGoogleButton.setTitleColor(.white, for: .normal)
        customGoogleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        view.addSubview(customGoogleButton)

        let customGoogleButtonLogout = UIButton(type: .system)
        customGoogleButtonLogout.frame = CGRect(x: 16, y: 350, width: view.frame.width / 2 + 50 , height: 50)
        customGoogleButtonLogout.backgroundColor = .lightGray
        customGoogleButtonLogout.setTitle("Logout google", for: .normal)
        customGoogleButtonLogout.addTarget(self, action: #selector(logoutGoogle), for: .touchUpInside)
        customGoogleButtonLogout.setTitleColor(.white, for: .normal)
        customGoogleButtonLogout.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        view.addSubview(customGoogleButtonLogout)

        GIDSignIn.sharedInstance().uiDelegate = self
    }

    fileprivate func setupLineButton() {

        let LineButtonLogin = UIButton(type: .system)
        LineButtonLogin.frame = CGRect(x: 16, y: 420, width: view.frame.width / 2 + 50 , height: 50)
        LineButtonLogin.backgroundColor = UIColor(r: 0, g: 195, b: 0)
        LineButtonLogin.setTitle("Log in with LINE", for: .normal)
        LineButtonLogin.setTitleColor(.white, for: .normal)
        LineButtonLogin.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        LineButtonLogin.addTarget(self, action: #selector(handleLoginLine), for: .touchUpInside)
        view.addSubview(LineButtonLogin)

        let LineButtonLogout = UIButton(type: .system)
        LineButtonLogout.frame = CGRect(x: 16, y: 480, width: view.frame.width / 2 + 50 , height: 50)
        LineButtonLogout.backgroundColor = UIColor(r: 198, g: 198, b: 198)
        LineButtonLogout.setTitle("Logout with LINE", for: .normal)
        LineButtonLogout.setTitleColor(.white, for: .normal)
        LineButtonLogout.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        LineButtonLogout.addTarget(self, action: #selector(handleLogoutLine), for: .touchUpInside)
        view.addSubview(LineButtonLogout)

        LineSDKLogin.sharedInstance().delegate = self
        self.apiClient = LineSDKAPI(configuration: LineSDKConfiguration.defaultConfig())
    }

    @objc private func handleLogoutLine() {
        self.apiClient?.logout(queue: .main, completion: { (success, error) in
            if success {
                self.presentAlert(message: "You have successfully logged out")
            } else {
                self.presentAlert(message: "The LINE Logout Failed \n \(String(describing: error?.localizedDescription))")
            }
        })
    }

    @objc private func handleLoginLine() {
        LineSDKLogin.sharedInstance().start()
    }

    @objc private func logoutGoogle() {
        GIDSignIn.sharedInstance().signOut()
        print("Logout Google Success")
    }

    @objc private func handleCustomGoogleSign() {
        GIDSignIn.sharedInstance().signIn()
    }

    fileprivate func setupFacebookButton() {
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 100, width: view.frame.width / 2 + 40 , height: 50)
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]

        // add custom login facebook
        let customFBButton = UIButton(type: .system)
        customFBButton.backgroundColor = UIColor(red: 53/255, green: 68/255, blue: 107/255, alpha: 1)
        customFBButton.frame = CGRect(x: 16, y: 160, width: view.frame.width / 2 + 40 , height: 50)
        customFBButton.setTitle("Custom FB Login here", for: .normal)
        customFBButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
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

extension LoginSDKController: LineSDKLoginDelegate {

    func didLogin(_ login: LineSDKLogin, credential: LineSDKCredential?, profile: LineSDKProfile?, error: Error?) {
        if error != nil {
            print("Error login Line" , error?.localizedDescription ?? "")
        } else {
            guard let profile = profile else { return }
            let accessToken = credential?.accessToken?.accessToken
            print(profile.pictureURL ?? "")
            presentAlert(message: "\(profile.displayName) \n useID:\(profile.userID) \n accessToken: \(String(describing: accessToken))")
        }
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
