//
//  SwitchEnumsAndTableViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/4/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

let MovieData = [
    ["title": "Jason Bourne",
     "cast": "Matt Damon, Alicia Vikander, Julia Stiles",
     "genre": "action"],

    ["title": "Suicide Squad",
     "cast": "Margot Robbie, Jared Leto, Will Smith",
     "genre": "action"],

    ["title": "Star Trek Beyond",
     "cast": "Chris Pine, Zachary Quinto, Zoe Saldana",
     "genre": "action"],

    ["title": "Deadpool",
     "cast": "Ryan Reynolds, Morena Baccarin, Gina Carano",
     "genre": "action"],

    ["title": "London Has Fallen",
     "cast": "Gerard Butler, Aaron Eckhart, Morgan Freeman, Angela Bassett",
     "genre": "action"],

    ["title": "Ghostbusters",
     "cast": "Kate McKinnon, Leslie Jones, Melissa McCarthy, Kristen Wiig",
     "genre": "comedy"],

    ["title": "Central Intelligence",
     "cast": "Dwayne Johnson, Kevin Hart",
     "genre": "comedy"],

    ["title": "Bad Moms",
     "cast": "Mila Kunis, Kristen Bell, Kathryn Hahn, Christina Applegate",
     "genre": "comedy"],

    ["title": "Keanu",
     "cast": "Jordan Peele, Keegan-Michael Key",
     "genre": "comedy"],

    ["title": "Neighbors 2: Sorority Rising",
     "cast": "Seth Rogen, Rose Byrne",
     "genre": "comedy"],

    ["title": "The Shallows",
     "cast": "Blake Lively",
     "genre": "drama"],

    ["title": "The Finest Hours",
     "cast": "Chris Pine, Casey Affleck, Holliday Grainger",
     "genre": "drama"],

    ["title": "10 Cloverfield Lane",
     "cast": "Mary Elizabeth Winstead, John Goodman, John Gallagher Jr.",
     "genre": "drama"],

    ["title": "A Hologram for the King",
     "cast": "Tom Hanks, Sarita Choudhury",
     "genre": "drama"],

    ["title": "Miracles from Heaven",
     "cast": "Jennifer Garner, Kylie Rogers, Martin Henderson",
     "genre": "indie"],
]


final class SwitchEnumsAndTableViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet private weak var tableview: UITableView!

    // MARK: - DummyData
    enum TableViewSection: Int {
        case action = 0, comedy, drama, indie, total
    }

    enum Detail: Int {
        case detailA
        case detailB
    }

    let SectionHeaderHeight: CGFloat = 25
    var data = [TableViewSection: [[String: String]]]()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Switch Enums And Table View"
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableview.dataSource = self
        tableview.delegate = self
        sortData()
    }

    // MARK: - Private Func
    private func sortData() {
        data[.action] = MovieData.filter({ $0["genre"] == "action" })
        data[.comedy] = MovieData.filter({ $0["genre"] == "comedy" })
        data[.drama] = MovieData.filter({ $0["genre"] == "drama" })
        data[.indie] = MovieData.filter({ $0["genre"] == "indie" })
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Medium", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func controllerDemo(view: Detail) -> UIViewController {
        let vc: UIViewController!
        switch view {
        case .detailA:
            vc = DetailA_ViewController()
            return vc
        case .detailB:
            vc = DetailB_ViewController()
            return vc
        }
    }
}

// MARK: - UITableViewDataSource
extension SwitchEnumsAndTableViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewSection.total.rawValue
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableSection = TableViewSection(rawValue: section), let moviData = data[tableSection] {
            return moviData.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let tableSection = TableViewSection(rawValue: indexPath.section), let movie = data[tableSection]?[indexPath.row] {
            cell.textLabel?.text = movie["title"]
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SwitchEnumsAndTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let tableSection = TableViewSection(rawValue: section), let moviData = data[tableSection], moviData.count > 0 {
            return SectionHeaderHeight
        }
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height))
        view.backgroundColor = UIColor.lightGray

        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
        label.textColor = UIColor.black

        if let tableSection = TableViewSection(rawValue: section) {
            switch tableSection {
            case .action: label.text = "Action"
            case .comedy: label.text = "Comedy"
            case .drama: label.text = "Drama"
            case .indie: label.text = "Indie"
            default: label.text = ""
            }
        }
        view.addSubview(label)
        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableSection = TableViewSection(rawValue: indexPath.section) else { return }
        switch tableSection {
        case .action:
            if let movie = data[tableSection]?[indexPath.row] {
                showAlert(message: movie["cast"]!)
            } else {
                showAlert(message: "error")
            }
        case .comedy:
            guard let view = Detail(rawValue: indexPath.row) else { return }
            let controller = controllerDemo(view: view)
            navigationController?.pushViewController(controller, animated: true)
        default: showAlert(message: "Error")
            return
        }
    }
}























