//
//  ContactCell.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 3/16/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

protocol ContactCellDelegate: class {
    func someMethodWantToCall(cell: UITableViewCell)
}

class ContactCell: UITableViewCell {

    weak var link: ContactCellDelegate?

    lazy var starButon: UIButton = {
        let bt = UIButton(type: .system)
        bt.setImage(#imageLiteral(resourceName: "star_select"), for: .normal)
        bt.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        return bt
    }()

    @objc private func handleMarkAsFavorite() {
        link?.someMethodWantToCall(cell: self)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(starButon)
        starButon.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        starButon.tintColor = .red
        accessoryView = starButon
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

