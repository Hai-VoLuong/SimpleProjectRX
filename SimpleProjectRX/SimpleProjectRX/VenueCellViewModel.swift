//
//  VenueCellViewModel.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/30/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift

final class VenueCellViewModel {

    // MARK: - Private Properties
    private var venue: Venue
    private var bag = DisposeBag()

    // MARK: - Public Propertiees
    var name: BehaviorSubject<String>
    var address: BehaviorSubject<String>
    var rating: BehaviorSubject<String>
    var image: BehaviorSubject<UIImage?>

    var photoPath: String? {
        return venue.thumbnail?.patch()
    }

    var photoURL: URL? {
        return URL(string: venue.thumbnail?.patch() ?? "")
    }


    //MARK: - init
    init(venue: Venue = Venue()) {
        self.venue = venue
        name = BehaviorSubject<String>(value: venue.name)
        address = BehaviorSubject<String>(value: venue.fullAddress)
        rating = BehaviorSubject<String>(value: String(describing: venue.rating))
        image = BehaviorSubject<UIImage?>(value:#imageLiteral(resourceName: "Bill_Gates"))

        guard let url = photoURL else { return }
        URLSession.shared.rx.data(request: URLRequest(url: url))
            .subscribe(onNext: { [weak self] (data) in
                guard let this = self else { return }
                DispatchQueue.main.async {
                    this.image.onNext(UIImage(data: data))
                }
            })
            .disposed(by: bag)
    }
}
