//
//  SectionsIntelligentlyController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/16/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class SectionsIntelligentlyController: UIViewController {

    fileprivate let cellId = "cell"

    fileprivate let names = ["Army", "Army", "Army", "Army", "Army", "Army", "Army", "Army"]
    fileprivate let anotherListNames = ["Bary", "Bary", "Bary", "Bary"]

    fileprivate let twoDimensionArray = [
        ["Army", "Army", "Army", "Army", "Army", "Army", "Army", "Army"],
        ["Bary", "Bary", "Bary", "Bary"],
        ["What", "What"]
    ]
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigations()
        setupUITableView()
    }

    private func setupNavigations() {
        title = "Sections Intelligently"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
    }

    private func setupUITableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}

extension SectionsIntelligentlyController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionArray.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Header"
        label.backgroundColor = .lightGray
        return label
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimensionArray[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        var name = self.names[indexPath.row]
        name = twoDimensionArray[indexPath.section][indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
}
