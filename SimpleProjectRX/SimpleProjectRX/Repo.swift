//
//  Repo.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/8/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import ObjectMapper

struct Repo: Mappable {

    var id = 0
    var name: String?
    var fullName: String?
    var urlString: String?
    var starCount = 0
    var folkCount = 0
    var avatarURLString: String?

    init?(map: Map) {
    }

    init() {
    }

    init(name: String) {
        self.name = name
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        fullName <- map["full_name"]

        urlString <- map["html_url"]
        starCount <- map["stargazers_count"]
        folkCount <- map["forks"]
        avatarURLString <- map["owner.avatar_url"]
    }
}

