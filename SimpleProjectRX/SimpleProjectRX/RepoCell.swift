//
//  RepoCellTableViewCell.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/9/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import Kingfisher

class RepoCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var starLabel: UILabel!
    @IBOutlet var folkLabel: UILabel!
    @IBOutlet var avatarImageView: UIImageView!

    static var cellIdentifier: String {
        return String(describing: self)
    }

    var repo: Repo! {
        didSet {
            guard let repo = repo else { return }
            nameLabel.text = repo.name
            starLabel.text = String(repo.starCount)
            folkLabel.text = String(repo.folkCount)

            if let url = URL(string: repo.avatarURLString ?? "") {
                avatarImageView.kf.setImage(with:  url)
            }
        }
    }

}
