//
//  DrinkCoffeeViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/25/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class DrinkCoffeeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Drink Coffee"
        setupNavigationBarItems()
    }

    func setupNavigationBarItems() {
        setupRightNavItems()
        setupRemainingNavItems()
    }

    fileprivate func setupRemainingNavItems() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }

    fileprivate func setupRightNavItems() {
        let favoriteButton = UIButton(type: .system)
        favoriteButton.setImage(#imageLiteral(resourceName: "favor_1").withRenderingMode(.alwaysOriginal), for: .normal)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)

        let searchButton = UIButton(type: .system)
        searchButton.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)

        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: favoriteButton),UIBarButtonItem(customView: searchButton)]
    }
}
