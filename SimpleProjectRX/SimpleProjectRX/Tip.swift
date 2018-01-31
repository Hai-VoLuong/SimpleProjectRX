//
//  Tip.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/29/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

let dateTimeFormatter = { () -> DateFormatter in
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MM-YYYY hh:mm:ss"
    return formatter
}()

class Tip: Mappable {
    var id = ""
    var createdAt = Date()
    var text = ""
    var photoPrefix = ""
    var photoSuffix = ""
    var user: UserMap?

    var createString: String {
        return dateTimeFormatter.string(from: createdAt)
    }

    required convenience init?(map: Map) {
        self.init()
        guard let _ = map.JSON["id"] as? String else { return nil }
    }

    func mapping(map: Map) {
        id <- map["id"]
        createdAt <- (map["createdAt"], DateTransform())
        text <- map["text"]
        photoPrefix <- map["photo.photo.prefix"]
        photoSuffix <- map["user.photo.suffix"]
        user <- map["user"]
    }
}
