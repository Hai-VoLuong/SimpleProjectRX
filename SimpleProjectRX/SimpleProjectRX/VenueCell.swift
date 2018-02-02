//
//  VenueCell.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/26/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

final class VenueCellModel {

    // MARK: - Private Properties
    private var venue: Venue
    private var bag = DisposeBag()

    // MARK: - Public Propertiees
    var name: BehaviorSubject<String>
    var address: BehaviorSubject<String>
    var rating: BehaviorSubject<String>

    var photoPath: String? {
        return venue.thumbnail?.patch()
    }

    // support kingfisher framework
    var photoURL: URL? {
        return URL(string: venue.thumbnail?.patch() ?? "")
    }

    //MARK: - init
    init(venue: Venue = Venue()) {
        self.venue = venue
        name = BehaviorSubject<String>(value: venue.name)
        address = BehaviorSubject<String>(value: venue.fullAddress)
        rating = BehaviorSubject<String>(value: String(describing: venue.rating))
    }
}

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
        viewModel.name.bind(to: nameLabel.rx.text).addDisposableTo(bag)
        viewModel.address.bind(to: addressLabel.rx.text).addDisposableTo(bag)
        viewModel.rating.bind(to: ratingLabel.rx.text).addDisposableTo(bag)
        thumnailImageView.kf.setImage(with: viewModel.photoURL)
    }
}
