//
//  VenueDetailViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/31/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxDataSources

final class VenueDetailViewController: UIViewController {

    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: VenueDetailModel?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        configTableView()
    }

    // MARK: - Private Func
    private func configTableView() {
        tableView.register(UINib(nibName: "InformationCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: "TipCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.estimatedRowHeight = 200

    }
}

