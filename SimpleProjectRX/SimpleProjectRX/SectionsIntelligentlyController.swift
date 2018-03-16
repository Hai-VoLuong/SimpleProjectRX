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
        ExpandableNames(isExpanded: true, names: ["Army", "Army", "Army", "Army", "Army", "Army", "Army", "Army"]),
        ExpandableNames(isExpanded: true, names: ["Bary", "Bary", "Bary", "Bary"]),
        ExpandableNames(isExpanded: true, names: ["What", "What"])
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
            for index in twoDimensionArray[section].names.indices {
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

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionArray[section].isExpanded {
            return 0
        }
        return twoDimensionArray[section].names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        var name = self.names[indexPath.row]
        name = twoDimensionArray[indexPath.section].names[indexPath.row]
        let nameShow = showIndexPath ? name : "\(name) Section: \(indexPath.section)"
        cell.textLabel?.text = nameShow
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let buttonHeader: UIButton = {
            let button = UIButton (type: .system)
            button.backgroundColor = .yellow
            button.setTitle("Close", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
            button.tag = section
            return button
        }()

        let nameLabel: UILabel = {
            let lb = UILabel()
            lb.text = "title"
            return lb
        }()

        let view: UIView = {
            let v = UIView()
            v.backgroundColor = .orange
            v.addSubview(buttonHeader)
            v.addSubview(nameLabel)
            buttonHeader.anchor(top: v.topAnchor, leading: nil, bottom: v.bottomAnchor, trailing: v.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 8) , size: .init(width: 50, height: 0))
            nameLabel.anchor(top: v.topAnchor, leading: v.leadingAnchor, bottom: v.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 50, height: 0))
            return v
        }()

        return view
    }

    @objc private func handleExpandClose(button: UIButton) {

        let section = button.tag
        var indexPaths = [IndexPath]()

        // mãng indexPaths theo section
        for row in twoDimensionArray[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }

        // delete section
        let isExpanded = twoDimensionArray[section].isExpanded
        twoDimensionArray[section].isExpanded = !isExpanded

        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)

        // nếu isExpaned là true thì delete còn false thì insert vào
        isExpanded ? tableView.deleteRows(at: indexPaths, with: .fade) : tableView.insertRows(at: indexPaths, with: .fade)

    }
}
