//
//  TipCell.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/1/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

struct TipModel {
    var title: String
    var subtitle: String
    var thumbImage: String
    var timeStamp: String
    var avatarURL: URL?
}

final class TipCell: UITableViewCell {
    // MARK: - IBoutlets
    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var createdAtLabel: UILabel!
}
