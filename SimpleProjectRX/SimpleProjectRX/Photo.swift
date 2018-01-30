//
//  Photo.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/29/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Photo: Object, Mappable {
    dynamic var id: String!
    dynamic var prefix: String = ""
    dynamic var suffix: String = ""
    dynamic var width: Int = 0
    dynamic var height: Int = 0

    override class func primaryKey() -> String? {
        return "id"
    }

    required convenience init?(map: Map) {
        self.init()
        if map.JSON["id"] == nil {
            return nil
        }
    }

    func mapping(map: Map) {
        id <- map["id"]
        prefix <- map["prefix"]
        suffix <- map["suffix"]
        width <- map["width"]
        height <- map["height"]
    }

    func patch(radioWith: Int = 2, radioHeight: Int = 2) -> String {
        let path = prefix + "\(width / radioWith)" + "x" + "\(height / radioHeight)" + suffix
        return path
    }
}
