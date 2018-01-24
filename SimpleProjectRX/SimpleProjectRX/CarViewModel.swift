//
//  CarViewModel.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/24/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import MVVM
import RxSwift

class CarViewModel: ViewModel {
    static let horsepowerPerKilowatt = 1.341
    private var car: Car
    let bag = DisposeBag()

    //let zondaF = Car(model: "Zonda F", make: "Pagani", kilowatts: 449, photoURL: "http://storage.pagani.com/view/1024/BIG_zg-4-def.jpg")

    var modelText: BehaviorSubject<String>
    var makeText: BehaviorSubject<String>
    var titleText: BehaviorSubject<String>
    var horsepowerText: BehaviorSubject<String>
    var photoURL: URL? {
        return URL(string: car.photoURL)
    }

    init(car: Car) {
        self.car = car

        modelText = BehaviorSubject<String>(value: car.model)
        modelText
            .subscribe(onNext: { model in
                car.model = model
            }).addDisposableTo(bag)

        makeText = BehaviorSubject<String>(value: car.make)
        makeText
            .subscribe(onNext: { make in
                car.make = make
            }).addDisposableTo(bag)

        titleText = BehaviorSubject<String>(value: car.model + car.make)
        Observable.combineLatest(modelText, makeText) { (model, make) -> String in
            return model + make
        }.bind(to: titleText).addDisposableTo(bag)

        horsepowerText = BehaviorSubject(value: "0")
        let kilowattText = BehaviorSubject(value: car.kilowatts)
        kilowattText
            .map({ kilowatt -> String in
                let horsepower = Int(round(Double(car.kilowatts) * CarViewModel.horsepowerPerKilowatt))
                return "\(horsepower) HP"
            }).bind(to: horsepowerText).addDisposableTo(bag)
    }
}
