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
    fileprivate let bag = DisposeBag()
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
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: VenueCell.self))({
                [weak self] (index, venue, cell) in
                guard let this = self else { return }
                cell.viewModel = this.viewModel.viewModelForItem(at: IndexPath(row: index, section: 0))
            }).addDisposableTo(bag)

        // itemsSelected
        _ = tableView.rx.itemSelected
            .map({ indexPath in
               self.viewModel.venueItem(at: indexPath)
            })
            .subscribe({ [weak self] event in
                guard let this = self else { return }
                switch event {
                case .next(let venue, let indexPath):
                    this.tableView.deselectRow(at: indexPath, animated: true)
                    let detail = VenueDetailViewController()
                    detail.viewModel = VenueDetailModel(venueId: venue.id)
                    this.navigationController?.pushViewController(detail, animated: true)
                case .error(let error):
                    this.alert(message: "error: \(error.localizedDescription)")
                default : break
                }
            })

        // load more
        tableView.rx.contentOffset
            .map { $0.y }
            .subscribe { [weak self] (event) in
                guard let this = self else { return }
                if let y = event.element {
                    let maximumOffset = this.tableView.contentSize.height - this.tableView.frame.size.height
                    if !this.viewModel.isLoadMore.value && y == maximumOffset {
                        this.viewModel.isLoadMore.value = true
                    }
                }
            }
            .disposed(by: bag)

        // section
        segmentControl.rx.selectedSegmentIndex
            .asObservable()
            .map({ rawValue -> DrinkViewModel.Section in
                return DrinkViewModel.Section(rawValue: rawValue)!
            })
            .bind(to: viewModel.section)
            .addDisposableTo(bag)


        // refresh
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                guard let this = self else { return }
                this.viewModel.refresh()
            }).addDisposableTo(bag)

        viewModel.isRefreshing.asDriver()
        .drive(refreshControl.rx.isRefreshing)
        .addDisposableTo(bag)
    }

    private func alert(message: String) {
        let alertController = UIAlertController(title: "RxSwfit", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.Action("OK", style: .default))
        present(alertController, animated: true, completion: nil)
    }
}

// MARKL: - Extenion DrinkCoffeeViewController Navigation
extension DrinkCoffeeViewController {

    fileprivate func setupRightNavItems() {

        let favoriteButton = UIButton(type: .system)
        favoriteButton.setImage(#imageLiteral(resourceName: "favor_1").withRenderingMode(.alwaysOriginal), for: .normal)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        favoriteButton.rx.tap
        .asDriver()
        .drive(onNext: {
            self.navigationController?.pushViewController(FavoriteViewController(), animated: true)
        }).addDisposableTo(bag)

        let searchButton = UIButton(type: .system)
        searchButton.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        searchButton.rx.tap
        .asDriver()
        .drive(onNext: {
            self.navigationController?.pushViewController(FavoriteViewController(), animated: true)
        }).addDisposableTo(bag)

        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: favoriteButton),UIBarButtonItem(customView: searchButton)]

    }
}
