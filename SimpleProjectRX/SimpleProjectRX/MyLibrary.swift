//
//  MyLibraryAPI.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/9/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RealmSwift

final class MyLibrary {

    // MARK: - private properties
    private let databaseManager = DatabaseManager()
    private let api = APIBase()

    static let shared = MyLibrary()

    private init() {
    }

    // MARK: - private func
    func addAll(by venues: [Venue]? = nil) {
        guard let venues = venues else { return }
        return databaseManager.addObjects(venues)
    }

    // MARK: - public func
    func fetch(by venueId: String) -> Venue? {
        let pre = NSPredicate(format: "id = %@", venueId)
        return databaseManager.object(Venue.self, filter: pre)
    }

    func getAll() -> [Venue]? {
        let results = databaseManager.objects(Venue.self)
        return Array(results)
    }

    func checkObjects(venues: [Venue]) -> [Venue]? {
        if venues.count == self.getAll()?.count {
            return self.getAll()
        }
        self.addAll(by: venues)
        return nil
    }
}
