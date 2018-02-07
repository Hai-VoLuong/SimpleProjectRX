//
//  Venue.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/29/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Venue: Object, Mappable {

    dynamic var id: String!
    dynamic var name: String = ""
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var rating: Double = 0.0
    dynamic var ratingColor: String = ""
    dynamic var category: String = ""
    dynamic var likes:String = ""
    dynamic var phone: String = ""
    dynamic private var address: String = ""
    dynamic private var city: String = ""
    dynamic var isFavorite = false

    var fullAddress: String {
        if city.isEmpty {
            return address
        } else {
            return address + ", " + city
        }
    }

    var thumbnail: Photo?
    var photos: [Photo] = []
    var tips: [Tip] = []

    override class func primaryKey() -> String {
        return "id"
    }

    required convenience init?(map: Map) {
        self.init()
        guard let _ = map.JSON["id"] as? String else { return nil }
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        latitude <- map["location.lat"]
        longitude <- map["location.lng"]
        rating <- map["rating"]
        ratingColor <- map["ratingColor"]
        category <- map["categories.0.name"]
        likes <- map["likes.summary"]
        phone <- map["contact.phone"]
        address <- map["location.address"]
        city <- map["location.city"]

        thumbnail <- map["photos.groups.0.items.0"]
        tips <- map["tips.groups.0.items"]
        photos <- map["photos.groups.0.items"]
    }
}
