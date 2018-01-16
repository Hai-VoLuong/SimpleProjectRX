//
//  Repository.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/16/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

struct RepositoryMedium {
    let fullName: String
    let description: String
    let starsCount: Int
    let url: String
}

extension RepositoryMedium {
    init?(from json: [String: Any]) {
        guard
            let fullName = json["full_name"] as? String,
            let description = json["description"] as? String,
            let starsCount = json["stargazers_count"] as? Int,
            let url = json["html_url"] as? String
            else { return nil }

        self.init(fullName: fullName, description: description, starsCount: starsCount, url: url)
    }
}
