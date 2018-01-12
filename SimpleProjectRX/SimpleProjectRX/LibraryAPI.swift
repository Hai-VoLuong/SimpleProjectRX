//
//  LibraryAPI.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/11/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import UIKit

// 1. Facade Design Pattern : provides a single interface to a complex subsystem.
// Instead of exposing the user to a set of classes and their APIs, you only expose one simple unified API

// should hold instances of PersistencyManager and HTTPClient. Then, LibraryAPI will expose a simple API to access those services.
final class LibraryAPI: Repository {

    typealias T = Album

    // MARK: - Propertiees
    private let persistencyManager = PersistencyManager()
    private let hTTPClient = HTTPClient()

    // isOnline determines if the server should be updated with any changes made to the albums list, such as added or deleted albums
    private let isOnline = false

    // 2. Singleton Design Pattern : ensures that only one instance exists for a given class and that there’s a global access point to that instance
    // For example Apple: UserDefaults.standard, UIApplication.shared, UIScreen.main, FileManager.default all return a Singleton object.
    static let shared = LibraryAPI()
    private init() {
        // 2. registered as an observer for the same notification
        NotificationCenter.default.addObserver(self, selector: #selector(downloadImage(with:)), name: .BLDownloadImage, object: nil)
    }

    func getAll() -> [Album] {
        return persistencyManager.getAll()
    }

    func add(_ album: Album, at index: Int) {
        persistencyManager.add(album, at: index)
        if isOnline {
            hTTPClient.postRequest("/api/addAlbum", body: album.description)
        }
    }

    func delete(at index: Int) {
        persistencyManager.delete(at: index)
        if isOnline {
            hTTPClient.postRequest("/api/deleteAlbum", body: "\(index)")
        }
    }

}
