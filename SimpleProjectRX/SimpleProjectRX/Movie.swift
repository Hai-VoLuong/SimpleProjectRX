//
//  Movie.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/19/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

struct Movie {
    let title: String
    let imageURL: String
    let releaseDate: String
    let purchasePrice: Price
    let summary: String
}

struct Price {
    let amount: String
    let currency: String
}
