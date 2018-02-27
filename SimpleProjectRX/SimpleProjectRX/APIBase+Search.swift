//
//  APIBase+Search.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 2/26/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import RxAlamofire

extension API {
    static func search(with keyword: String) -> Observable<[Venue]> {
        let path = "venues/explore"
        let params: JSObject = [
            "query": keyword,
            "ll": "16.06778, 108.22083",
            "client_secret": "OMEDU0AA2GUBQSATQLRIHDSYYGC5JD0IPGU5II4IPDHWAYMO",
            "client_id": "ESKZ0I0VLGKYSV3KMT5FTDBS45E4HFNRYX4QFZJWMDAT3K1K",
            "v": 20170503,
            "venuePhotos": 1
        ]
        return Observable<[Venue]>.create({ (observer) -> Disposable in
           _ = RxAlamofire.request(.get, "\(apiEndpoint)\(path)", parameters: params)
                .flatMap({ (dataRequest) -> Observable<Any> in
                    return dataRequest.validate(statusCode: 200..<300).rx.json()
                })
                .subscribe(onNext: { data in
                    var venues: [Venue] = []
                    guard let json = data as? JSObject,
                        let response = json["response"] as? JSObject,
                        let groups = response["groups"] as? JSArray else {
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
                }, onError: { error in
                    observer.onError(error)
                }, onCompleted: {
                    observer.onCompleted()
                })
            return Disposables.create()
        })
    }
}
