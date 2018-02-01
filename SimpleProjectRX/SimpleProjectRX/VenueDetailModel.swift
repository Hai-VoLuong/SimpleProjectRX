//
//  VenueDetailModel.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/1/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift
import MVVM

final class VenueDetailModel: MVVM.ViewModel {

    // MARK: - Properties
    private var venue: Venue
    private let bag = DisposeBag()

    // MARK: - init
    init(venue: Venue) {
        self.venue = venue
        setup()
    }

    // MARK: - Private Func
    private func setup() {
        APIBase.getVenue(id: venue.id)
            .subscribe(onNext: {[weak self] venue in
                print(venue)
                }, onError: { error in
                    print("error: \(error.localizedDescription)")
            }).addDisposableTo(bag)
    }

}
