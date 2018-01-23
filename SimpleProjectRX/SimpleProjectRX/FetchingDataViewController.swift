//
//  FetchingDataViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/2/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class FetchingDataViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    fileprivate let bag = DisposeBag()
    fileprivate let eventService = EventService()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "fetching data"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        getData()
    }

    private func getData() {
        eventService.getEvents()

        eventService.events.asObservable()
            .bind(to: tableView.rx.items) { [weak self] tableView, index, event in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

                cell.textLabel?.text = event.name
                cell.detailTextLabel?.text = event.repo + ", " + event.action.replacingOccurrences(of: "Event", with: "").lowercased()
                cell.imageView?.kf.setImage(with: event.imageUrl, placeholder: UIImage(named: "blank-avatar"))

                return cell
            }
            .disposed(by: bag)

    }
}
