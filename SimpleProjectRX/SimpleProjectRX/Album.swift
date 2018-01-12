//
//  File.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/11/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

// 8. Design Memento Pattern : can be achieved through archiving and serialization
// Before Swift 4 : Value types like struct and enum required a sub object that can extend NSObject and conform to NSCoding

// Swift 4 use Codable. This protocol is the only thing required to make a Swift type Encodable and Decodable
struct Album: Codable {
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
