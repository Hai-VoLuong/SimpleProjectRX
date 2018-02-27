//
//  RealmObservable.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/9/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import RxSwift
import RealmSwift

public struct RealmChangeset {

    public let deleted: [Int]

    public let inserted: [Int]

    public let updated: [Int]
}


final class RealmObservable {

    static let bag = DisposeBag()

    static func changeset<T>(from data: Results<T>) -> Observable<([T], RealmChangeset)> {
        return Observable<([T], RealmChangeset)>.create({ observer -> Disposable in
            let token = data.observe({ (collectionChange) in
                switch collectionChange {
                case .update(let results, let deletions, let insertions, let modifications):
                    let changeset = RealmChangeset(deleted: deletions, inserted: insertions, updated: modifications)
                    var temps: [T] = []
                    temps.append(contentsOf: results)
                    observer.onNext((temps, changeset))
                case .initial(_): break
                case .error(let error):
                    observer.onError(error)
                }
            })

            return Disposables.create {
                token.invalidate()
            }
        })
    }

    // MARK :- Observer object change
    static func propertyChanges<T>(from object: T) -> Observable<PropertyChange> where T: Object {
        return Observable<PropertyChange>.create { observer in
            let token = object.observe { change in
                switch change {
                case .change(let changes):
                    for change in changes {
                        observer.onNext(change)
                    }
                case .deleted: break
                case .error(let error):
                    observer.onError(error)
                }
            }

            return Disposables.create {
                token.invalidate()
            }
        }
    }
}
