//
//  VibloViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/4/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class VibloViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Dummy data
    enum Demo: Int {
        case passDataBackUsingProtocol = 0
        case Search
        case CircleView
        case MVVM
        case LazyClosures
        case APIReactiveRxSwift
        case ClosuresGenericsPOP
    }

    var dummyData: [String] = [
        "Passing data back using protocol",
        "Search",
        "Circle View",
        "MVVM Chưa Xong",
        "Lazy Closures",
        "API theo phong cách reactive với RxSwift Moya",
        "Sử dụng Closures, Generics, POP"
    ]

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Viblo"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Public Func
    func controllerDemo(view: Demo) -> UIViewController {
        let vc: UIViewController!
        switch view {
        case .passDataBackUsingProtocol:
            vc = OneViewController()
            return vc
        case .Search:
            vc = SearchViblo_ViewController()
            return vc
        case .CircleView:
            vc = CircleViewViewController()
            return vc
        case .MVVM:
            vc = RepoListViewController()
            return vc
        case .LazyClosures:
            vc = LazyClosureViewController()
            return vc
        case .APIReactiveRxSwift:
            vc = APIReactiveRxSwiftViewController()
            return vc
        case .ClosuresGenericsPOP:
            vc = ClosuresGenericsPOPViewController()
            return vc
        }
    }
}

// MARK: - UITableViewDataSource
extension VibloViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dummyData[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension VibloViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let demo = Demo(rawValue: indexPath.row) else { return }
        let controller = controllerDemo(view: demo)
        navigationController?.pushViewController(controller, animated: true)
    }
}
