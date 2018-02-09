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

final class VenueDetailModel {

    // MARK: - Properties
    private var venue = Venue()
    private let bag = DisposeBag()
    var dataSource: Variable<[DetailVenueSection]> = Variable([])
    var urlString: Variable<[String]> = Variable([])

    // MARK: - init
    init(venueId: String) {
        if let venue = Venue.fetch(by: venueId) {
            self.venue = venue
        } else {
            self.venue.id = venueId
        }
        setup()
    }

    // MARK: - Private Func
        private func setup() {
        APIBase.getVenue(id: venue.id)
            .subscribe(onNext: {[weak self] venue in
                guard let this = self else { return }
                this.venue = venue
                let urlString: [String] = this.venue.photos.map({$0.patch()})
                this.urlString.value = urlString
                this.dataSource.value = [
                    DetailVenueSection.informations(
                        title: "Information",
                        items: [
                            SectionItem.information(viewModel: InformationModel(title: "Name : ", content: this.venue.name)),
                            SectionItem.information(viewModel: InformationModel(title: "Address : ", content: this.venue.fullAddress)),
                            SectionItem.information(viewModel: InformationModel(title: "Categories : ", content: this.venue.category)),
                            SectionItem.information(viewModel: InformationModel(title: "Rating : ", content: String(this.venue.rating)))
                        ]),
                    DetailVenueSection.tips(
                        title: "Tips",
                        items: this.venue.tips.map({ tip -> SectionItem in
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
