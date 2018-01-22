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
        setupUI()
    }

    private func setupUI() {
        tableView.register(MovieCell.self, forCellReuseIdentifier: "Cell")
        tableView.contentInset = UIEdgeInsets(top: 22, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tableView.dataSource = self
    }
}

extension ClosuresGenericsPOPViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        let movieViewModel = MovieViewModel(model: movie)
        cell.displayMovieInCell(using: movieViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

