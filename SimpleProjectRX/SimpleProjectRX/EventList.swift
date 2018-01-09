//
//  EventList.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/9/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import ObjectMapper

class EventListInput: APIInputBase {
    init(repoFullName: String) {
        super.init(urlString: String(format: URLs.eventList, repoFullName), parameters: nil, requestType: .get)
    }
}

class EventListOutput: APIOutputBase {

    var events = [Event]()

    init(events: [Event]) {
        self.events = events
        super.init()
    }

    required init?(map: Map) {
        super.init(map: map)
    }
}
