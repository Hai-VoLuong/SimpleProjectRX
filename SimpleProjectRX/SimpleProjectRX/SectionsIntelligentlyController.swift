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
    fileprivate var showIndexPath = false

    fileprivate let names = ["Army", "Army", "Army", "Army", "Army", "Army", "Army", "Army"]
    fileprivate let anotherListNames = ["Bary", "Bary", "Bary", "Bary"]

    fileprivate var twoDimensionArray = [
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

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
    }

    @objc private func handleShowIndexPath() {
        var indexPathsToReload = [IndexPath]()
        for section in twoDimensionArray.indices {
            for index in twoDimensionArray[section].indices {
                let indexPath = IndexPath(row: index, section: section)
                indexPathsToReload.append(indexPath)
            }
        }
        showIndexPath = !showIndexPath
        let animationStyle = showIndexPath ? UITableViewRowAnimation.right : .left
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
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
        let button = UIButton (type: .system)
        button.backgroundColor = .yellow
        button.setTitle("show", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        return button
    }

    @objc private func handleExpandClose(button: UIButton) {

        let section = button.tag
        var indexPaths = [IndexPath]()

        // index first rows
        for row in twoDimensionArray[section].indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }

        // delete first rows
        twoDimensionArray[section].removeAll()
        tableView.deleteRows(at: indexPaths, with: .fade)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimensionArray[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        var name = self.names[indexPath.row]
        name = twoDimensionArray[indexPath.section][indexPath.row]
        let nameShow = showIndexPath ? name : "\(name) Section: \(indexPath.section)"
        cell.textLabel?.text = nameShow
        return cell
    }
}
