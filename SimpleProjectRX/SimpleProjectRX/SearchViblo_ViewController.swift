//
//  SearchViblo_ViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/5/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViblo_ViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    // MARK: - Properties
    var shownCities = [String]()
    let disaposeBag = DisposeBag()
    let allCities: [String] = ["Oklahoma", "Chicago", "Moscow", "Danang", "Vancouver", "Praga"]

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        searchData()
    }

    // MARK: - Private Func
    private func searchData() {
        searchBar.rx.text.orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] query in
                guard let this = self else { return }
                this.shownCities = this.allCities.filter { $0.hasPrefix(query)}
                this.tableView.reloadData()
            }).addDisposableTo(disaposeBag)
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
