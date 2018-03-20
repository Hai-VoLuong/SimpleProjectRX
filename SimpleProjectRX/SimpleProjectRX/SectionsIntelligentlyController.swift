//
//  SectionsIntelligentlyController.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/16/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import Contacts

class SectionsIntelligentlyController: UIViewController, ContactCellDelegate {

    fileprivate let cellId = "cell"
    fileprivate var showIndexPath = false

    fileprivate var twoDimensionArray = [
        ExpandableNames(isExpanded: true, names: [
        "army", "tryky" ,"Bill"].map({
           FavoritableContact(name: $0, hasFavorite: false)
        })),
        ExpandableNames(isExpanded: true, names: [FavoritableContact(name: "Patrick", hasFavorite: false)])
    ]
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContacts()
        setupNavigations()
        setupUITableView()
    }

    private func fetchContacts() {
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("Failed to request access: ", error)
                return
            }
            if granted {
                print("Access granted")
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])

                do {
                    var favoritableContacts = [FavoritableContact]()

                   try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointerIfYouWantToStopEnumrating) in
                        print(contact.givenName)
                        print(contact.familyName)
                        print(contact.phoneNumbers.first?.value.stringValue ?? "")

                        favoritableContacts.append(FavoritableContact(name: contact.givenName + " " + contact.familyName, hasFavorite: false))
                    })

                    let names = ExpandableNames(isExpanded: true, names: favoritableContacts)
                    self.twoDimensionArray = [names]

                } catch let err {
                    print("Failed to enumerate contacts: ",err)
                }
            } else {
                print("Access denied...")
            }
        }
    }

    private func setupNavigations() {
        title = "Sections Intelligently"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
    }

    @objc private func handleShowIndexPath() {
        var indexPathsToReload = [IndexPath]()
        for section in twoDimensionArray.indices {
            for index in twoDimensionArray[section].names.indices {
                let indexPath = IndexPath(row: index, section: section)
                indexPathsToReload.append(indexPath)
            }
        }
        showIndexPath = !showIndexPath
        let animationStyle = showIndexPath ? UITableViewRowAnimation.right : .left
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
    }

    private func setupUITableView() {
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }

    // delegate
    func someMethodWantToCall(cell: UITableViewCell) {
        guard let indexPathTap = tableView.indexPath(for: cell) else { return }
        let contact = twoDimensionArray[indexPathTap.section].names[indexPathTap.row]
        let hasFavorited = contact.hasFavorite
        twoDimensionArray[indexPathTap.section].names[indexPathTap.row].hasFavorite = !hasFavorited
        print(contact)
        cell.accessoryView?.tintColor = hasFavorited ? .lightGray : .red
    }
}

extension SectionsIntelligentlyController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionArray[section].isExpanded {
            return 0
        }
        return twoDimensionArray[section].names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell
        cell.link = self
        let contact = twoDimensionArray[indexPath.section].names[indexPath.row]
        let nameShow = showIndexPath ? contact.name : "\(contact.name) Section: \(indexPath.section)"
        cell.textLabel?.text = nameShow
        cell.accessoryView?.tintColor = contact.hasFavorite ? .red : .lightGray
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let buttonHeader: UIButton = {
            let button = UIButton (type: .system)
            button.backgroundColor = .yellow
            button.setTitle("Close", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
            button.tag = section
            return button
        }()

        let nameLabel: UILabel = {
            let lb = UILabel()
            lb.text = "title"
            return lb
        }()

        let view: UIView = {
            let v = UIView()
            v.backgroundColor = .orange
            v.addSubview(buttonHeader)
            v.addSubview(nameLabel)
            buttonHeader.anchor(top: v.topAnchor, leading: nil, bottom: v.bottomAnchor, trailing: v.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 8) , size: .init(width: 50, height: 0))
            nameLabel.anchor(top: v.topAnchor, leading: v.leadingAnchor, bottom: v.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0), size: .init(width: 50, height: 0))
            return v
        }()

        return view
    }

    @objc private func handleExpandClose(button: UIButton) {

        let section = button.tag
        var indexPaths = [IndexPath]()

        // mãng indexPaths theo section
        for row in twoDimensionArray[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }

        // delete section
        let isExpanded = twoDimensionArray[section].isExpanded
        twoDimensionArray[section].isExpanded = !isExpanded

        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)

        // nếu isExpaned là true thì delete còn false thì insert vào
        isExpanded ? tableView.deleteRows(at: indexPaths, with: .fade) : tableView.insertRows(at: indexPaths, with: .fade)

    }
}
