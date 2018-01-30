//
//  VenueCell.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/26/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift

final class VenueCell: UITableViewCell {

    // MARK: - IBoutlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var thumnailImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!

    // MARK: - Properties
    let bag = DisposeBag()

    var viewModel = VenueCellModel() {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        updateUI()
    }

    private func updateUI() {
        ratingLabel.layer.cornerRadius = 10
        viewModel.name.bind(to: nameLabel.rx.text).addDisposableTo(bag)
        viewModel.address.bind(to: addressLabel.rx.text).addDisposableTo(bag)
        viewModel.rating.bind(to: ratingLabel.rx.text).addDisposableTo(bag)
        thumnailImageView.setImage(path: viewModel.photoPath)
        .subscribe()
        .disposed(by: bag)
    }
}
