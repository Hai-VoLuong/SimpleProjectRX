//
//  MainNaviController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/14/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class MainNaviController: UINavigationController {

    override func viewDidLoad() {
        view.backgroundColor = .white

        if isLoggedIn() {
            let tabbarController = TabbarController()
            viewControllers = [tabbarController]
        } else {
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }

    private func isLoggedIn() -> Bool {
        return true
    }

    @objc private func showLoginController() {
        let loginController = LoginWalkthroughController()
        present(loginController, animated: true) {

        }
    }
}
