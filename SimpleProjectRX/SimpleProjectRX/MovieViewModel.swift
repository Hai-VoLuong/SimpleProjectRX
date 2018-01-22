//
//  MovieViewModel.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/19/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

class MovieViewModel {
    let title: String
    let imageURL: String
    let releaseDate: String
    let purchasePrice: String
    let summary: String

    init(model: Movie) {
        self.title = model.title.uppercased()
        self.imageURL = model.imageURL
        self.releaseDate = "Realase date: \(model.releaseDate)"
        if let doublePurchasePrice = Double(model.purchasePrice.amount) {
            self.purchasePrice = String(format: "%.02f %@", doublePurchasePrice, model.purchasePrice.currency)
        } else {
            self.purchasePrice = "Not available for Purchase"
        }
        self.summary = model.summary == "" ? "No data provided " : model.summary
    }
}
