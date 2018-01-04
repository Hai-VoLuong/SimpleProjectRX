//
//  SearchViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/2/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
    }

    // MARK: - Dummy data
    var datas = String()
}
