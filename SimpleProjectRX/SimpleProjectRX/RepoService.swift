//
//  RepoService.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/9/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import RxSwift

protocol RepoServiceProtocol {
    func repoList(input: RepoListInput) -> Observable<RepoListOutput>
    func eventList(input: EventListInput) -> Observable<EventListOutput>
}

class RepoService: APIService, RepoServiceProtocol {

    func repoList(input: RepoListInput) -> Observable<RepoListOutput> {
        return self.request(input)
        .observeOn(MainScheduler.instance)
        .shareReplay(1)
    }

    func eventList(input: EventListInput) -> Observable<EventListOutput> {
        return self.requestArray(input)
        .observeOn(MainScheduler.instance)
        .map { events -> EventListOutput in
            return EventListOutput(events: events)
        }
        .shareReplay(1)
    }
}
