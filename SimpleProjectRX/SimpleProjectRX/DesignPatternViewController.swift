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

    @IBOutlet private var horizontalScrollerView: HorizontalScrollerView!

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

    fileprivate func showDataForAlbum(at index: Int) {
        if (index < allAlbums.count && index > -1) {
            let album = allAlbums[index]
            currentAlbumData = album.tableRepresentation
        } else {
            currentAlbumData = nil
        }
        tableView.reloadData()
        horizontalScrollerView.delegate = self
        horizontalScrollerView.dataSource = self
        horizontalScrollerView.reload()
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

// MARK: - HorizontalScrollerViewDelegate
extension DesignPatternViewController: HorizontalScrollerViewDelegate {
    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, didSelectViewAt index: Int) {

        let previousAlbumView = horizontalScrollerView.view(at: currentAlbumIndex) as! AlbumView
        previousAlbumView.highlightAlbum(false)

        currentAlbumIndex = index

        let albumView = horizontalScrollerView.view(at: currentAlbumIndex) as! AlbumView
        albumView.highlightAlbum(true)

        showDataForAlbum(at: index)
    }
}

// MARK: - HorizontalScrollerViewDataSource
extension DesignPatternViewController: HorizontalScrollerViewDataSource {

    func numberOfViews(in horizontalScrollerView: HorizontalScrollerView) -> Int {
        return allAlbums.count
    }

    func horizontalScrollerView(_ horizontalScrollerView: HorizontalScrollerView, viewAt index: Int) -> UIView {
        let album = allAlbums[index]
        let albumView = AlbumView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), coverUrl: album.coverUrl)
        if currentAlbumIndex == index {
            albumView.highlightAlbum(true)
        } else {
            albumView.highlightAlbum(false)
        }
        return albumView
    }
}

