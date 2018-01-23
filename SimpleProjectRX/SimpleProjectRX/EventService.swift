//
//  EventService.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/23/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import RxSwift

class EventService {
    let events = Variable<[Events]>([])
    let bag = DisposeBag()

    func getEvents() {
        guard let url = URL(string: "https://api.github.com/repos/ReactiveX/RxSwift/events") else { return }

        RxAPI.request(url: url)
            .filter({objects in
                return !objects.isEmpty
            })
            .map({ objects in
                return objects.flatMap(Events.init)
            })
            .subscribe(onNext: { [weak self] (events) in
                guard let this = self else { return }
                this.processEvents(events)
            })
            .addDisposableTo(bag)
    }

    func processEvents(_ newEvents: [Events]) {
        // grab the last 50 events from the repository’s event list
        var updateEvents = newEvents + events.value
        if updateEvents.count > 50 {
            updateEvents = [Events](updateEvents.prefix(upTo: 50))
        }
        events.value = updateEvents
    }
}
