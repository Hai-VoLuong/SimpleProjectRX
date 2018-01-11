//
//  File.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/11/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

struct Album {
    let title : String
    let artist : String
    let genre : String
    let coverUrl : String
    let year : String
}

extension Album: CustomStringConvertible {
    var description: String {
        return "title: \(title)" +
            " artist: \(artist)" +
            " genre: \(genre)" +
            " coverUrl: \(coverUrl)" +
        " year: \(year)"
    }
}

// 3. Decorator Design Pattern :  dynamically adds behaviors and responsibilities to an object without modifying its code.
// In Swift there are two very common implementations of this pattern: Extensions and Delegation

 // Will define a new method that returns a data structure which can be used easily with UITableView.
typealias AlbumData = (title: String, value: String)

extension Album {
    var tableRepresentation: [AlbumData] {
        return [
            ("Artist", artist),
            ("Album", title),
            ("Genre", genre),
            ("Year", year)
        ]
    }
}
