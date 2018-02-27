//
//  SearchViewModel.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/26/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import RxSwift
import RxCocoa

final class SearchViewModel {

    let variable = Variable<[VenueCellModel]>([])
    private let bag = DisposeBag()

    init(searchControl: ControlProperty<String?>) {
        searchControl.orEmpty
        .debounce(0.5, scheduler: MainScheduler.instance)
            .filter({ str -> Bool in
                return str.count >= 3
            })
            .flatMapLatest({ keyword in
                return API.search(with: keyword)
            })
            .map({ venues -> [VenueCellModel] in
                return venues.map({ venue -> VenueCellModel in
                    return VenueCellModel(venue: venue)
                })
            })
            .subscribeOn(MainScheduler.instance)
            .subscribe({ event in
                switch event {
                case .next(let viewModels):
                    self.variable.value = viewModels
                case .error(_), .completed:
                    self.variable.value = []
                }
            }).addDisposableTo(bag)

//        searchControl.orEmpty
//            .filter({ str -> Bool in
//                return str.count < 3
//            })
//            .subscribe(onNext: { _ in
//                self.variable.value = []
//            }).addDisposableTo(bag)
    }
}
