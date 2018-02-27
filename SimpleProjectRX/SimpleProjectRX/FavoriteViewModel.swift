//
//  FavoriteViewModel.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/12/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MVVM

class FavoriteViewModel: MVVM.ViewModel {
    let venues: Variable<[Venue]> = Variable([])
    let bag = DisposeBag()

    init() {
        guard let venuesIsFavorie = MyLibrary.shared.objectsIsFavorite() else { return }
        venues.value = venuesIsFavorie
    }

    func viewModelForItem(at indexPath: IndexPath) -> VenueCellModel {
        guard indexPath.row >= 0 && indexPath.row < venues.value.count else { return VenueCellModel() }
        return VenueCellModel(venue: venues.value[indexPath.row])
    }
}
