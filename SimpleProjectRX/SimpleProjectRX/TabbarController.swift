//
//  TabbarController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/2/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class TabbarController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
       // tabBar.tintColor = UIColor(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)

        let congtyController = HomeViewController()
        congtyController.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home_1"))
        let congtyNavigation = UINavigationController(rootViewController: congtyController)

        let vibloController = VibloViewController()
        vibloController.tabBarItem = UITabBarItem(title: "Viblo", image: #imageLiteral(resourceName: "favor"), selectedImage: #imageLiteral(resourceName: "favor_1"))
        let vibloNavigation = UINavigationController(rootViewController: vibloController)

        let mediumController = MediumViewController()
        mediumController.tabBarItem = UITabBarItem(title: "Medium", image: #imageLiteral(resourceName: "me"), selectedImage: #imageLiteral(resourceName: "me_1"))
        let mediumNavigation = UINavigationController(rootViewController: mediumController)

        let settingController = RaywenderViewController()
        settingController.tabBarItem = UITabBarItem(title: "Raywender", image: #imageLiteral(resourceName: "find"), selectedImage: #imageLiteral(resourceName: "find_1"))
        let settingNavigation = UINavigationController(rootViewController: settingController)

        viewControllers = [congtyNavigation, vibloNavigation, mediumNavigation, settingNavigation]
    }
}
