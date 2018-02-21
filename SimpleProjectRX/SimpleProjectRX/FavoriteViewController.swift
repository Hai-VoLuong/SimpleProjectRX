//
//  FavoriteViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/26/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MVVM

final class FavoriteViewController: UIViewController, MVVM.View {

    @IBOutlet private var tableView: UITableView!

    var viewModel = FavoriteViewModel() {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "favorite"
        configTableView()
        updateView()
    }

    func updateView() {
        setupTableViewBinding()
        tableView.reloadData()
    }

    private func configTableView() {
        tableView.register(UINib(nibName: "VenueCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 200
    }

    func setupTableViewBinding() {
        viewModel.venues.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: VenueCell.self)) ({ [weak self] (index, venue, cell) in
                guard let this = self else { return }
                cell.viewModel = this.viewModel.viewModelForItem(at: IndexPath(row: index, section: 0))
            })
    }
}
