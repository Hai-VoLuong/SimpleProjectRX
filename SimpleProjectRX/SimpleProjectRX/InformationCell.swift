//
//  InformationCell.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/1/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

struct InformationModel {
    let title: String
    var content: String
}

final class InformationCell: UITableViewCell {

    // MARK: - IBoutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var thumbImageView: UIImageView!

}
