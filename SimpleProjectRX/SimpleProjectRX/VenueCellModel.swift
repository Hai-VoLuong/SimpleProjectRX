//
//  VenueCellModel.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/30/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift

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
