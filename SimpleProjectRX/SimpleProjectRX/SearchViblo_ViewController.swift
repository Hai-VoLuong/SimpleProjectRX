//
//  SearchViblo_ViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/5/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class SearchViblo_ViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    // MARK: - Properties
    var shownCities = [String]()
    let allCities: [String] = ["Oklahoma", "Chicago", "Moscow", "Danang", "Vancouver", "Praga"]

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        shownCities = allCities
    }

    func searchData() {

    }

}

// MARK: - UITableViewDataSource
extension SearchViblo_ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        return cell
    }
}
