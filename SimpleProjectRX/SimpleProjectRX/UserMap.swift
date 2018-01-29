//
//  Tip.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/29/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import ObjectMapper

class UserMap: Mappable {
    var id: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var address: String = ""
    var gender: String = ""
    var email: String = ""
    var photoPrefix: String = ""
    var photoSuffix: String = ""
    var fullName: String {
        return firstName + " " + lastName
    }

    var avatar: URL? {
        return URL(string: photoPrefix + "width960" + photoSuffix)
    }
    var name: String {
        return firstName + " " + lastName
    }

    required init?(map: Map) { }

    func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        address <- map["homeCity"]
        gender <- map["gender"]
        email <- map["contact.email"]
        photoPrefix <- map["photo.prefix"]
        photoSuffix <- map["photo.suffix"]
    }
}
