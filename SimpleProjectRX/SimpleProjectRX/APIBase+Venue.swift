//
//  APIBase+Venue.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/29/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift

extension APIBase {
    class func getVenues(params: JSObject) -> Observable<[Venue]> {
        var path = "venues/explore?client_secret=OMEDU0AA2GUBQSATQLRIHDSYYGC5JD0IPGU5II4IPDHWAYMO&limit=10&ll=16.054407,108.202167&client_id=ESKZ0I0VLGKYSV3KMT5FTDBS45E4HFNRYX4QFZJWMDAT3K1K&v=20170503&venuePhotos=1"
        for param in params {
            path += "&\(param.key)=\(String(describing: param.value))"
        }

        let object = Observable<[Venue]>.create({ observer -> Disposable in
            _ = APIBase.request(path: path).subscribe(onNext: { (json) in
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
                    print(item)
                }

            })
            return Disposables.create()
        })
        return object
    }
}
