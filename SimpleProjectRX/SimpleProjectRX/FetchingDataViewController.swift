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
        tableView.dataSource = self
        getData()
    }

    private func getData() {
        eventService.getEvents()

        eventService.events.asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let this = self else { return }
                this.tableView.reloadData()
            })
            .addDisposableTo(eventService.bag)

    }
}

extension FetchingDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventService.events.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let event = eventService.events.value[indexPath.row]

        cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = event.repo + ", " + event.action.replacingOccurrences(of: "Event", with: "").lowercased()
        cell.imageView?.kf.setImage(with: event.imageUrl, placeholder: UIImage(named: "blank-avatar"))
        return cell
    }
}
