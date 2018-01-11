//
//  DesignPatternViewController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/11/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

private enum Constants {
    static let CellIdentifier = "Cell"
}

final class DesignPatternViewController: UIViewController {

    // MARK: - IBoutlets
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var undoBarButtonItem: UIBarButtonItem!
    @IBOutlet private var trashBarButtonItem: UIBarButtonItem!

    // MARK: - Properties
    fileprivate var currentAlbumIndex = 0
    fileprivate var currentAlbumData: [AlbumData]?
    fileprivate var allAlbums = [Album]()

    // MARK - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Design Patterns"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.CellIdentifier)
        tableView.dataSource = self

        getAPI()
    }

    // MARK: - Private Func
    private func getAPI() {
        allAlbums = LibraryAPI.shared.getAll()
        showDataForAlbum(at: currentAlbumIndex)
    }

    private func showDataForAlbum(at index: Int) {
        if (index < allAlbums.count && index > -1) {
            let album = allAlbums[index]
            currentAlbumData = album.tableRepresentation
        } else {
            currentAlbumData = nil
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension DesignPatternViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let albumData = currentAlbumData else {
            return 0
        }
        return albumData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier, for: indexPath)
        if let albumData = currentAlbumData {
            let row = indexPath.row
            cell.textLabel?.text = albumData[row].title
            cell.detailTextLabel?.text = albumData[row].value
        }
        return cell
    }
}

