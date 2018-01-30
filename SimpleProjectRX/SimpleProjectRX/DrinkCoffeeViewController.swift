//
//  DrinkCoffeeViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/25/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class DrinkCoffeeViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!

    // MARK: - Private Properties
    private let bag = DisposeBag()
    private var refreshControl = UIRefreshControl()
    var viewModel = DrinkViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Drink Coffee"
        setupRightNavItems()
        configuration()
    }

    // MARK: - Private Func
    private func configuration() {
        tableView.register(UINib(nibName: "VenueCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 143.0
        tableView.addSubview(refreshControl)
        viewModel.venues.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "VenueCell", cellType: VenueCell.self))({
                [weak self] (index, venue, cell) in
                print(venue)
            }).addDisposableTo(bag)

    }
}

// MARKL: - Extenion DrinkCoffeeViewController Navigation
extension DrinkCoffeeViewController {

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
