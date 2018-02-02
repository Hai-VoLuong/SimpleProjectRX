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
import RxDataSources

enum SectionItem {
    case information(viewModel: InformationModel)
    case tip(viewModel: TipModel)
}

enum DetailVenueSection {
    case informations(title: String, items: [SectionItem])
    case tips(title: String, items: [SectionItem])
}

extension DetailVenueSection: SectionModelType {

    typealias Item = SectionItem

    var items: [SectionItem] {
        switch self {
        case .informations(title: _, items: let items):
            return items.map({$0})
        case .tips(title: _, items: let items):
            return items.map({$0})
        }
    }

    init(original: DetailVenueSection, items: [SectionItem]) {
        switch original {
        case let .informations(viewModel):
            self = .informations(title: viewModel.title, items: viewModel.items)
        case let .tips(viewModel):
            self = .tips(title: viewModel.title, items: viewModel.items)
        }
    }
}

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
