//
//  DatabaseManager.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/9/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import RxSwift
import RealmSwift

class DatabaseManager {

    fileprivate var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

extension DatabaseManager {

    // MARK: - fetch object
    func object<T: Object>(_ type: T.Type, filter predicate: NSPredicate? = nil) -> T? {
        var results: Results<T>
        if let pre = predicate {
            results = realm.objects(type).filter(pre)
        } else {
            results = realm.objects(type)
        }

        guard !results.isEmpty else {
            return nil
        }

        return results.first
    }

    // MARK: - fetch objects
    func objects<T: Object>(_ type: T.Type, filter predicate: NSPredicate? = nil, sortBy propertiesSort: [String: Bool]? = nil) -> Results<T> {
        var results: Results<T>
        if let pre = predicate {
            results = realm.objects(type).filter(pre)
        } else {
            results = realm.objects(type)
        }

        if let propertiesSort = propertiesSort {
            for property in propertiesSort {
                results = results.sorted(byKeyPath: property.0, ascending: property.1)
            }
        }
        return results
    }

    // MARK:  - add object
    func addObject<T: Object>(_ object: T) {
        do {
            realm.beginWrite()
            realm.add(object, update: true)
            try realm.commitWrite()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func addObjects<T: Object, S: Sequence>(_ objects: S) where S.Iterator.Element == T {
        do {
            realm.beginWrite()
            for item in objects {
                realm.add(item, update: true)
            }
            try realm.commitWrite()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    // MARK: - update object
    func write() -> Observable<Void> {
        return Observable.create({ (observer) -> Disposable in
            do {
                try self.realm.write {
                    observer.onCompleted()
                }
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        })
    }

    // MARK: - remove object
    func deleteObject<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteObjects<T: Object, S: Sequence>(_ objects: S) where S.Iterator.Element == T {
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
