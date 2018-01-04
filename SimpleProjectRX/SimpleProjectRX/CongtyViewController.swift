//
//  HomeViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/2/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class CongtyViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Dummy Data
    fileprivate enum Demo: Int {
        case calculator
        case validateLogin
        case search
        case galleryImage
        case mutipCell
        case customObservable
        case fetchDataNetwork
        case mvvm
    }

    fileprivate let dummyDatas: [String] = [
        "Calculator",
        "Validate Login",
        "Search",
        "Gallery Image",
        "Multiple Cell Custom Types",
        "Custom Observable",
        "Fetching Data From the Web",
        "MVVM - Demo",
        ]

    // MARK: - private func
    fileprivate func controllerDemo(demo: Demo) -> UIViewController {
        let vc: UIViewController!
        switch demo {
        case .calculator:
            vc = CalculatorViewController()
            return vc
        case .validateLogin:
            vc = ValidateLoginViewController()
            return vc
        case .search:
            vc = SearchViewController()
            return vc
        case .galleryImage:
            vc = GalleryImageViewController()
            return vc
        case .mutipCell:
            vc = MultipleCellViewController()
            return vc
        case .customObservable:
            vc = CustomObservableViewController()
            return vc
        case .fetchDataNetwork:
            vc = FetchingDataViewController()
            return vc
        case .mvvm:
            vc = MVVMViewController()
            return vc
        }
    }


    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self

    }

}

// MARK: - UITableViewDelegate
extension CongtyViewController: UITableViewDataSource {
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
extension CongtyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let demo = Demo(rawValue: indexPath.row) else { return }
        let controller = controllerDemo(demo: demo)
        navigationController?.pushViewController(controller, animated: true)
    }
}

