//
//  SearchDrinkViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/26/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import MVVM
import RxSwift
import RxCocoa

final class SearchDrinkViewController: UIViewController, MVVM.View {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var indicator: UIActivityIndicatorView!

    var viewModel: SearchViewModel!
    private var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Drink"
        updateView()
        setupObservables()
        setupSearchBar()
    }

    func updateView() {
        setupTableView()
        setupViewModel()
    }

    func setupTableView() {
        tableView.register(UINib(nibName: "VenueCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 143
    }

    func setupViewModel() {
        viewModel = SearchViewModel(searchControl: searchBar.rx.text)
    }

    func setupSearchBar() {
        let textField = searchBar.value(forKey: "_searchField") as? UITextField
        textField?.clearButtonMode = .never
    }

    func setupObservables() {
        searchBar.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .map { (str) -> Bool in
                return str.count >= 3
            }
            .bind(to: indicator.rx.isAnimating)
            .disposed(by: bag)

        viewModel.variable.asObservable()
            .do(onNext: { _ in
                self.indicator.stopAnimating()
            }, onError: { _ in
                self.indicator.stopAnimating()
            }, onCompleted: { _ in
                self.indicator.stopAnimating()
            })
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: VenueCell.self)) { (index, model, cell) in
                cell.viewModel = model
        }.addDisposableTo(bag)
    }
}
