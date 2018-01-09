//
//  RepoListInput.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/9/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import ObjectMapper

class RepoListInput: APIInputBase {
    init() {
        super.init(urlString: URLs.repoList, parameters: nil, requestType: .get)
    }
}

class RepoListOutput: APIOutputBase {

    var repositories: [Repo]?

    override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)

        repositories <- map["items"]
    }

}
