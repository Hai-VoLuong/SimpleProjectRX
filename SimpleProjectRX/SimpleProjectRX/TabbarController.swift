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

        let homeController = HomeViewController()
        homeController.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home_1"))
        let homeNavigation = UINavigationController(rootViewController: homeController)

        let favoriteController = FavoriteViewController()
        favoriteController.tabBarItem = UITabBarItem(title: "Favorite", image: #imageLiteral(resourceName: "favor"), selectedImage: #imageLiteral(resourceName: "favor_1"))
        let favoriteNavigation = UINavigationController(rootViewController: favoriteController)

        let profileController = ProfileViewController()
        profileController.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "me"), selectedImage: #imageLiteral(resourceName: "me_1"))
        let profileNavigation = UINavigationController(rootViewController: profileController)

        let settingController = SettingViewController()
        settingController.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "find"), selectedImage: #imageLiteral(resourceName: "find_1"))
        let settingNavigation = UINavigationController(rootViewController: settingController)

        viewControllers = [homeNavigation, favoriteNavigation, profileNavigation, settingNavigation]
    }
}
