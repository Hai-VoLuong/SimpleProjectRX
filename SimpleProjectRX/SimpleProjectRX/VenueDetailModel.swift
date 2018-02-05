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

// Item
enum SectionItem {
    case information(viewModel: InformationModel)
    case tip(viewModel: TipModel)
}

// Section
enum DetailVenueSection {
    case informations(title: String, items: [Item])
    case tips(title: String, items: [Item])
}

extension DetailVenueSection: SectionModelType {

    typealias Item = SectionItem

    var items: [Item] {
        switch self {
        case .informations(title: _, items: let items):
            return items.map({$0})
        case .tips(title: _, items: let items):
            return items.map({$0})
        }
    }

    init(original: DetailVenueSection, items: [Item]) {
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
    private var venue = Venue()
    private let bag = DisposeBag()
    var dataSource: Variable<[DetailVenueSection]> = Variable([])

    // MARK: - init
    init(venue: Venue) {
        self.venue = venue
        setup()
    }

    // MARK: - Private Func
        private func setup() {
        APIBase.getVenue(id: venue.id)
            .subscribe(onNext: {[weak self] venue in
                guard let this = self else { return }
                this.venue = venue

                this.dataSource.value = [
                    DetailVenueSection.informations(
                        title: "Information",
                        items: [
                            SectionItem.information(viewModel: InformationModel(title: "Name : ", content: this.venue.name)),
                            SectionItem.information(viewModel: InformationModel(title: "Address : ", content: this.venue.fullAddress)),
                            SectionItem.information(viewModel: InformationModel(title: "Categories : ", content: this.venue.category)),
                            SectionItem.information(viewModel: InformationModel(title: "Rating : ", content: String(this.venue.rating)))
                        ]),
                    DetailVenueSection.tips(title: "Tips", items: this.venue.tips.map({ tip -> SectionItem in
                        return SectionItem.tip(viewModel: TipModel(
                            title: tip.user?.fullName ?? "",
                            subtitle: tip.text,
                            timeStamp: tip.createAtString,
                            avatarURL: tip.user?.avatar
                        ))
                    }))
                ]
                }, onError: { error in
                    print("error: \(error.localizedDescription)")
            }).addDisposableTo(bag)
    }

}
