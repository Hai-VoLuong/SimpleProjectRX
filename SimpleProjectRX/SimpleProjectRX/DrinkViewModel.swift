//
//  DrinkViewModel.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/29/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift
import MVVM

class DrinkViewModel {

    enum Section: Int {
        case coffee = 0
        case drink

        var name: String {
            switch self {
            case .coffee:
                return "coffee"
            case .drink:
                return "drink"
            }
        }
    }

    // MARK: - Properties
    var venues: Variable<[Venue]> = Variable([])
    var isLoading: PublishSubject<Bool> = PublishSubject()
    var isRefreshing: Variable<Bool> = Variable(false)
    var isLoadMore: Variable<Bool> = Variable(false)
    var section: Variable<Section> = Variable(.coffee)
    private var bag = DisposeBag()

    init() {
        self.setup()
    }

    // MARK: - Private Func
    private func setup() {
        isLoadMore.asObservable()
            .filter({ $0 == true })
            .subscribe(onNext: { [weak self] _ in
                guard let this = self else { return }
                if this.venues.value.count % 10 == 0 {
                    this.getVenues()
                }
            }).addDisposableTo(bag)

        section.asObservable()
        .skip(1)
            .subscribe(onNext: { [weak self] section in
                guard let this = self else { return }
                this.venues.value.removeAll()
                this.getVenues()
            })
        .disposed(by: bag)
    }

    func refresh() {
        // isRefreshing = false
        if isRefreshing.value {
            return
        }
        isRefreshing.value = true
        venues.value.removeAll()
        getVenues()
    }

    private func getVenues() {
        var params: JSObject = [:]
        params["section"] = section.value.rawValue
        params["offset"] = venues.value.count
        APIBase.getVenues(params: params)
            .subscribe { [weak self] (event) in
                guard let this = self else { return }
                if let venues = event.element {
                    this.venues.value.append(contentsOf: venues)
                    this.isLoading.onCompleted()
                } else {
                    if let error = event.error {
                        this.isLoading.onError(error)
                    }
                }
                this.isRefreshing.value = false
                this.isLoadMore.value = false
            }
            .disposed(by: bag)
    }
}

extension DrinkViewModel: MVVM.ViewModel {
    func viewModelForItem(at indexPath: IndexPath) -> VenueCellModel {
        guard indexPath.count < venues.value.count else { return VenueCellModel() }
        let venue = venues.value[indexPath.row]
        return VenueCellModel(venue: venue)
    }
}




