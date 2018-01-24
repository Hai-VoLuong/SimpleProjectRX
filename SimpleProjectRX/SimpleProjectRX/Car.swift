//
//  Car.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/24/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

class Car {
    var model: String
    var make: String
    var kilowatts: Int
    var photoURL: String

    init(model: String, make: String, kilowatts: Int, photoURL: String) {
        self.model = model
        self.make = make
        self.kilowatts = kilowatts
        self.photoURL = photoURL
    }
}
