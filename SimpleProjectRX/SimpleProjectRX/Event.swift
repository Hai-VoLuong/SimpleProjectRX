//
//  Event.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/8/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import ObjectMapper

struct Event: Mappable {

    var id: String?
    var type: String?
    var avatarString: String?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        type <- map["type"]
        avatarString <- map["actor.avatar_url"]
    }
}
