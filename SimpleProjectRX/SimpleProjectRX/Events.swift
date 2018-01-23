//
//  Events.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/23/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

class Events {
    let repo: String
    let name: String
    let imageUrl: URL
    let action: String

    init?(dictionary: JObject) {
        guard let repoDict = dictionary["repo"] as? JObject,
            let repoName = repoDict["name"] as? String,

            let actor = dictionary["actor"] as? JObject,
            let actorName = actor["display_login"] as? String,

            let actorUrlString = actor["avatar_url"] as? String,
            let actorUrl = URL(string: actorUrlString),

            let actionType = dictionary["type"] as? String
            else {
                return nil
        }

        repo = repoName
        name = actorName
        imageUrl = actorUrl
        action = actionType
    }
}
