//
//  HomeViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/2/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

enum Demo: Int {
    case SwitchEnumAndTableView
}

final class MediumViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Dummy Data

    fileprivate let dummyDatas: [String] = [
        "Switch Enum And TableView",
        ]

    // MARK: - private func
    fileprivate func controllerDemo(view: Demo) -> UIViewController {
        let vc: UIViewController!
        switch view {
        case .SwitchEnumAndTableView:
            vc = SwitchEnumsAndTableViewController()
            return vc
        }
    }

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Medium"
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self

    }

}

// MARK: - UITableViewDelegate
extension MediumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyDatas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dummyDatas[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MediumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let demo = Demo(rawValue: indexPath.row) else { return }
        let controller = controllerDemo(view: demo)
        navigationController?.pushViewController(controller, animated: true)
    }
}


