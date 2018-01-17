//
//  LanguageListMVCViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/16/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

protocol LanguageListViewControllerDelegate: class {
    func languageListViewController(_ viewController: LanguageListMVCViewController, didSelectLanguage language: String)
    func languageListViewControllerDidCancel(_ viewController: LanguageListMVCViewController)
}

final class LanguageListMVCViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var language: [String] = [String]()
    weak var delegate: LanguageListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "2 LanguageListMVC"
        setupUI()
        loadData()
    }

    //MARK: - Private Func
    private func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.cancel))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func loadData() {
        GithubService.shared.getLangueList(completionHandle: { [weak self] result in
            guard case let .success(newLangugues) = result else { return }
            guard let this = self else { return }
            this.language = newLangugues
            this.tableView.reloadData()
        })
    }

    @objc private func cancel() {
        delegate?.languageListViewControllerDidCancel(self)
    }
}

extension LanguageListMVCViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return language.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = language[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

extension LanguageListMVCViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.languageListViewController(self, didSelectLanguage: language[indexPath.row])
    }
}
