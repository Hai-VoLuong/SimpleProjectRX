//
//  PersistencyManager.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/11/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

//  save the album data locally

protocol Repository {

    associatedtype T

    func getAll() -> [T]
    func add(_ album: T ,at index: Int ) -> Void
    func delete(at index: Int ) -> Void

   // func get( identifier:Int ) -> T?
   // func update( article:T ) -> Bool

}

 typealias T = Album

final class PersistencyManager: Repository {

    private var albums = [Album]()

    init() {
        //Dummy list of albums
        let album1 = Album(title: "Best of Bowie",
                           artist: "David Bowie",
                           genre: "Pop",
                           coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_david_bowie_best_of_bowie.png",
                           year: "1992")

        let album2 = Album(title: "It's My Life",
                           artist: "No Doubt",
                           genre: "Pop",
                           coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_no_doubt_its_my_life_bathwater.png",
                           year: "2003")

        let album3 = Album(title: "Nothing Like The Sun",
                           artist: "Sting",
                           genre: "Pop",
                           coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_sting_nothing_like_the_sun.png",
                           year: "1999")

        let album4 = Album(title: "Staring at the Sun",
                           artist: "U2",
                           genre: "Pop",
                           coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_u2_staring_at_the_sun.png",
                           year: "2000")

        let album5 = Album(title: "American Pie",
                           artist: "Madonna",
                           genre: "Pop",
                           coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_madonna_american_pie.png",
                           year: "2000")

        albums = [album1, album2, album3, album4, album5]
    }


    func getAll() -> [Album] {
        return albums
    }

    func add(_ album: Album, at index: Int) {
        if (albums.count >= index) {
            albums.insert(album, at: index)
        } else {
            albums.append(album)
        }
    }

    func delete(at index: Int) {
        albums.remove(at: index)
    }

}
