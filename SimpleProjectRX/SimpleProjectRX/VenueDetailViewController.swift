//
//  VenueDetailViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/31/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

final class VenueDetailViewController: UIViewController {

    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: VenueDetailModel?
    var bag = DisposeBag()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        configRightBarButtonItems()
        configTableView()
        configPageView()
    }

    // MARK: - Private Func
    private func configRightBarButtonItems() {
        let favoriteButton: UIBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "favor"), style: .done, target: nil, action: nil)
        favoriteButton.rx.tap.asObservable().subscribe(onNext:{

        }).addDisposableTo(bag)
         navigationItem.rightBarButtonItem = favoriteButton
    }

    private func configTableView() {
        tableView.register(UINib(nibName: "InformationCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        tableView.register(UINib(nibName: "TipCell", bundle: nil), forCellReuseIdentifier: "TipCell")
        tableView.estimatedRowHeight = 200
        tableView.estimatedRowHeight = UITableViewAutomaticDimension

        let dataSource = RxTableViewSectionedReloadDataSource<DetailVenueSection>()
        dataSource.configureCell = {(dataSource, tableView, indexpath, item) in
            switch dataSource[indexpath] {
            case .information(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as? InformationCell else { return InformationCell() }
                cell.viewModel = viewModel
                return cell
            case .tip(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TipCell") as? TipCell else { return TipCell() }
                cell.viewModel = viewModel
                return cell
            }
        }

        dataSource.titleForHeaderInSection = {(dataSource, index) in
            switch dataSource[index] {
            case .informations(let title, _ ):
                return "\(title)"
            case .tips(let title, _ ):
                return "\(title)"
            }
        }

        viewModel?.dataSource.asObservable()
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: bag)
    }

    private func configPageView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = headerView.bounds.size
        layout.footerReferenceSize = .zero
        layout.headerReferenceSize = .zero
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = .leastNormalMagnitude
        layout.minimumLineSpacing = .leastNormalMagnitude
        let collectionView = UICollectionView(frame: headerView.bounds, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
        viewModel?.urlString.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: "Cell"))({ (indexPath, url, cell) in
               let imageView = UIImageView(frame: cell.bounds)
                imageView.contentMode = .scaleAspectFill
                imageView.setImage(path: url).subscribe().addDisposableTo(self.bag)
                cell.addSubview(imageView)

            }).addDisposableTo(bag)
        headerView.addSubview(collectionView)
    }
}

