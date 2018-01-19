//
//  ClosuresGenericsPOPViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/19/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class ClosuresGenericsPOPViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    fileprivate var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sử dụng Closures, Generics, POP"
        tableView.register(MovieCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ClosuresGenericsPOPViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieCell
        cell.priceLabel.text = "afsdfads"
        return cell
    }
}

extension ClosuresGenericsPOPViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
