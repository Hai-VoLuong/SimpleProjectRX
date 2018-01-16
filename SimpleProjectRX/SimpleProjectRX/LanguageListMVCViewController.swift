//
//  LanguageListMVCViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/16/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class LanguageListMVCViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LanguageListMVC"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension LanguageListMVCViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
}

extension LanguageListMVCViewController: UITableViewDelegate {}
