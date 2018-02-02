//
//  VenueDetailViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/31/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

final class VenueDetailViewController: UIViewController {

    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: VenueDetailModel?
    var bag = DisposeBag()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        configTableView()
    }

    // MARK: - Private Func
    private func configTableView() {
        tableView.register(UINib(nibName: "InformationCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        tableView.register(UINib(nibName: "TipCell", bundle: nil), forCellReuseIdentifier: "TipCell")
        tableView.estimatedRowHeight = 200
        tableView.estimatedRowHeight = UITableViewAutomaticDimension

        let dataSource = RxTableViewSectionedReloadDataSource<DetailVenueSection>()
        dataSource.configureCell = {(dataSource, tableView, indexpath, item) in
            switch dataSource[indexpath] {
            case .information(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as? InformationCell else { return InformationCell() }
                cell.viewModel = viewModel
                return cell
            case .tip(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TipCell") as? TipCell else { return TipCell() }
                cell.viewModel = viewModel
                return cell
            }
        }

        dataSource.titleForHeaderInSection = {(dataSource, index) in
            if index == 0 {
                return "Information"
            } else {
                return "Tips"
            }
        }

        viewModel?.dataSource.asObservable()
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: bag)
    }
}

