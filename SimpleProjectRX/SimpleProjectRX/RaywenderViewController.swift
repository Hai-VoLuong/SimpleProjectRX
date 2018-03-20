//
//  SearchViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/2/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class RaywenderViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Dummy Data
    fileprivate enum Demo: Int {
        case DesignPattern
        case liveStream
        case magicalGrid
        case animatedCircleProgressBar
        case tinderProfileGrid
        case autoLayoutThroughExtensions
        case parsingJSONWithDecodable
        case loginSDK
        case loginWalkthrough
        case contactsController
        case autoLayout
    }

    fileprivate let dummyDatas: [String] = [
        "Design Patterns",
        "Live Stream Live",
        "Magical Grid to Tinde",
        "Animated Circle ProgressBar",
        "Tinder Profile Grid",
        "AutoLayoutThroughExtensions",
        "ParsingJSON With Decodable",
        "Login SDK",
        "Login Walk through",
        "Contacts",
        "Auto Layout"
        ]

    // MARK: - private func
    fileprivate func controllerDemo(demo: Demo) -> UIViewController {
        let vc: UIViewController!
        switch demo {
        case .DesignPattern:
            vc = DesignPatternViewController()
            return vc
        case .liveStream:
            vc = LiveStreamController()
            return vc
        case .magicalGrid:
            vc = MagicalGridController()
            return vc
        case .animatedCircleProgressBar:
            vc = AnimatedCircleProgressBar()
            return vc
        case .tinderProfileGrid:
            vc = TinderProfileGrid()
            return vc
        case .autoLayoutThroughExtensions:
            vc = AutoLayoutThroughExtensions()
            return vc
        case .parsingJSONWithDecodable:
            vc = ParsingJSONWithDecodable()
            return vc
        case .loginSDK:
            vc = LoginSDKController()
            return vc
        case .loginWalkthrough:
            vc = LoginWalkthroughController()
            return vc
        case .contactsController:
            vc = ContactsController()
            return vc
        case .autoLayout:
            vc = AutoLayoutController()
            return vc
        }
    }


    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Raywender"
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self

    }

}

// MARK: - UITableViewDelegate
extension RaywenderViewController: UITableViewDataSource {
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
extension RaywenderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let demo = Demo(rawValue: indexPath.row) else { return }
        let controller = controllerDemo(demo: demo)
        navigationController?.pushViewController(controller, animated: true)
    }
}
