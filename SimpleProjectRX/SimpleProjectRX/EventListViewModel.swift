//
//  EventListViewModel.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/9/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import RxSwift
import RxCocoa
import Action

final class EventListViewModel {

    // MARK: - Properties
    let repoService: RepoServiceProtocol
    let bag = DisposeBag()

    // MARK: - Input
    private(set) var repo: Variable<Repo>

    // MARK: - Output
    private(set) var eventList: Variable<[Event]>

    init(repoService: RepoServiceProtocol, repo: Variable<Repo>) {
        self.repoService = repoService
        self.repo = repo
        self.eventList = Variable<[Event]>([])
        bindOutput()
    }

    private func bindOutput() {
        repo
        .asObservable()
        .filter { $0.fullName != nil && !$0.fullName!.isEmpty }
        .map { $0.fullName! }
        .flatMap {repoFullName -> Observable<EventListOutput> in
            return self.repoService.eventList(input: EventListInput(repoFullName: repoFullName))
        }
        .subscribe(onNext: { [weak self] (output) in
            self?.eventList.value = output.events
        }, onError: { error in
            print(error)
        })
        .disposed(by: bag)
    }
}
