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
        setupRightNavItems()
    }

    fileprivate func setupRightNavItems() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false

        let favoriteButton = UIButton(type: .system)
        favoriteButton.setImage(#imageLiteral(resourceName: "favor_1").withRenderingMode(.alwaysOriginal), for: .normal)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        favoriteButton.addTarget(self, action: #selector(pushFavoriteController), for: .touchUpInside)

        let searchButton = UIButton(type: .system)
        searchButton.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        searchButton.addTarget(self, action: #selector(pushSearchController), for: .touchUpInside)

        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: favoriteButton),UIBarButtonItem(customView: searchButton)]
    }

    @objc private func pushFavoriteController() {
        navigationController?.pushViewController(FavoriteViewController(), animated: true)
    }

    @objc private func pushSearchController() {
        navigationController?.pushViewController(SearchDrinkViewController(), animated: true)
    }
}
