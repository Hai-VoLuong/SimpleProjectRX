//
//  APIBase+Venue.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/29/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

extension APIBase {

    static let clientId = "J1G4TOY3HLH504HI42JQ3ACQTLYGOYZ4ARC2VBG3IE1DLTTX"
    static let clientSecret = "S1HWM5P0CJKJZICFHSHLQ4SVINTWZINKNGCNYXOZRAN1JC3X"
    static let version = "20171207"

    class func getVenues(params: JSObject) -> Observable<[Venue]> {
        var path = "venues/explore?client_secret=\(clientSecret)&limit=10&ll=16.054407,108.202167&client_id=\(clientId)&v=\(version)&venuePhotos=1"
        for param in params {
            path += "&\(param.key)=\(String(describing: param.value))"
        }

        return Observable<[Venue]>.create({ observer -> Disposable in
           _ = APIBase.request(path: path).subscribe(onNext: { json in
                var venues: [Venue] = []
                guard let groups = json["groups"] as? JSArray else {
                    observer.onError(RxError.noElements)
                    return
                }
                guard let items = groups.first?["items"] as? JSArray else {
                    observer.onError(RxError.noElements)
                    return
                }

                for item in items {
                    if let venueObject = item["venue"] as? JSObject {
                        if let venue = Mapper<Venue>().map(JSON: venueObject) {
                            venues.append(venue)
                        }
                    }
                }
                observer.onNext(venues)
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }

    class func getVenue(id: String) -> Observable<Venue> {
        return Observable<Venue>.create({ observer -> Disposable in
            let path = "venues/\(id)?client_secret=\(clientSecret)&client_id=\(clientId)&v=\(version)"
           _ = APIBase.request(path: path).subscribe({ event in
                switch event {
                case .error:
                    observer.onError(RxError.noElements)
                case .next(let json):
                    var venue: Venue!
                    if let venueObject = json["venue"] as? JSObject {
                        venue = Mapper<Venue>().map(JSON: venueObject)
                    }
                    observer.onNext(venue)
                case .completed:
                    observer.onCompleted()
                }
            })
            return Disposables.create()
        })
    }
}
