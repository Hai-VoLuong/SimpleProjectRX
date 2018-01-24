//
//  MVVMViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/2/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MVVM

final class MVVMViewController: UIViewController, MVVM.View {

    @IBOutlet private weak var tableView: UITableView!

    let bag = DisposeBag()

    var viewModel = CarListViewModel() {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MVVM"
        tableView.rowHeight = 100
        tableView.register(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        updateView()
    }

    func updateView() {
        setupObservable()
    }

    private func setupObservable() {
        viewModel.dataObservable
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: CarTableViewCell.self)) { [weak self] (row, _, cell) in
                guard let this = self else { return }
                cell.viewModel = this.viewModel.viewModelForItem(at: IndexPath(row: row, section: 0))
            }
            .addDisposableTo(bag)
    }
}




