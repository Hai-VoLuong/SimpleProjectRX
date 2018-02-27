//
//  Photo.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/29/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import ObjectMapper

class Photo: Mappable {
    var id: String = ""
    var prefix: String = ""
    var suffix: String = ""
    var width: Int = 0
    var height: Int = 0

    required convenience init?(map: Map) {
        self.init()
        guard let _ = map.JSON["id"] as? String else { return nil }
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
