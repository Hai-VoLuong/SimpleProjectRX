//
//  VenueCell.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/26/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

class VenueCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var thumnailImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!

    override func awakeFromNib() {
        updateUI()
    }

    private func updateUI() {
        ratingLabel.layer.cornerRadius = 10
    }
}
