//
//  RepoListViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/8/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwinjectStoryboard

final class RepoListViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    private var refreshControl: UIRefreshControl!
    fileprivate let bag = DisposeBag()
    fileprivate var viewModel: RepoListViewModel!
    fileprivate var navigator: Navigator!

    static func createWith(navigator: Navigator, storyboard: UIStoryboard, viewModel: RepoListViewModel) -> RepoListViewController {
        let controller = storyboard.instantiateViewController(ofType: RepoListViewController.self)
        controller.navigator = navigator
        controller.viewModel = viewModel

        return controller
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repo List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil)
        tableView.register(UINib(nibName: RepoCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: RepoCell.cellIdentifier)
        tableView.rowHeight = 92

        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableView.addSubview(refreshControl)

        //bindUI()

        // viewModel.loadDataAction.execute("First load")
    }

    // MARK: - Private Func
    private func bindUI() {
        self.navigationItem.rightBarButtonItem!.rx
            .bind(to: viewModel.loadDataAction) { _ in return "Refresh button" }

        viewModel
            .repoList
            .asObservable()
            .bind(to: tableView.rx.items) { [weak self] tableView, index, event in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.cellIdentifier, for: indexPath)
                self?.config(cell, at: indexPath)
                return cell
            }
            .disposed(by: bag)

        viewModel.isLoadingData
            .asDriver()
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: bag)

//        tableView.rx
//            .modelSelected(Repo.self)
//            .subscribe(onNext: { [weak self](repo) in
//                guard let this = self else { return }
//                self?.navigator.show(segue: .eventList(repo: Variable(repo)), sender: this)
//            })
//            .disposed(by: bag)

        refreshControl.rx
            .bind(to: viewModel.loadDataAction, controlEvent: refreshControl.rx.controlEvent(.valueChanged)) { _ in
                return "Refresh button"
        }

    }

    private func config(_ cell: UITableViewCell, at indexPath: IndexPath) {
        if let cell = cell as? RepoCell {
            cell.repo = viewModel.repoList.value[indexPath.row]
        }
    }
}
