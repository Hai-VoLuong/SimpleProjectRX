//
//  RepositoryListViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/16/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import SafariServices

final class RepositoryListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    fileprivate let refreshControl = UIRefreshControl()
    fileprivate var currentLanguage = "Swift"
    fileprivate var repositories = [RepositoryMedium]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        reloaData()
    }

    private func setupUI() {
        tableView.register(UINib(nibName: "DetailViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.insertSubview(refreshControl, at: 0)
        refreshControl.addTarget(self, action: #selector(self.reloaData), for: .valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(self.openListLanguage))
    }

    @objc fileprivate func reloaData() {
        refreshControl.beginRefreshing()
        navigationItem.title = currentLanguage

        GithubService.shared.getMostPopularRepositories(byLanguge: currentLanguage, completionHandler: { [weak self] result in
            self?.refreshControl.endRefreshing()
            guard let this = self else { return }
            switch result {
            case let .error(error):
                this.presentAlert(message: error.localizedDescription)
            case let .success(newRepositories):
                this.repositories = newRepositories
                this.tableView.reloadData()
            }
        })
    }

    @objc private func openListLanguage() {
        let languageViewController = LanguageListMVCViewController()
        languageViewController.delegate = self
        navigationController?.pushViewController(languageViewController, animated: true)
    }

    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}

extension RepositoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DetailViewCell
        let repo = repositories[indexPath.row]
        cell.selectionStyle = .none
        cell.setName(repo.fullName)
        cell.setDescription(repo.description)
        return cell
    }

}

extension RepositoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reposity = repositories[indexPath.row]
        let url = URL(string: reposity.url)!
        let safariViewController = SFSafariViewController(url: url)
        navigationController?.pushViewController(safariViewController, animated: true)
    }
}

extension RepositoryListViewController: LanguageListViewControllerDelegate {
    func languageListViewController(_ viewController: LanguageListMVCViewController, didSelectLanguage language: String) {
        currentLanguage = language
        navigationController?.popViewController(animated: true)
        self.reloaData()

    }

    func languageListViewControllerDidCancel(_ viewController: LanguageListMVCViewController) {
        navigationController?.popViewController(animated: true)
    }
}

