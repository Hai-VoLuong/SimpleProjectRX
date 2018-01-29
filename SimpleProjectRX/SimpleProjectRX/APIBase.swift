//
//  APIBase.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/29/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

let apiEndpoint = "https://api.foursquare.com/v2/"

class APIBase {

    class func request(path: String) -> Observable<JSObject> {
        guard let url = URL(string: apiEndpoint + path) else { return .empty() }

        return Observable<JSObject>.create({ observer -> Disposable in
            _ = URLSession.shared.rx.data(request: URLRequest(url: url))
                .catchError({ error -> Observable<Data> in
                    observer.onError(error)
                    return .empty()
                })
                .map({data -> JSObject in
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSObject
                        return json ?? [:]
                    } catch {
                        return [:]
                    }
                })
                .observeOn(MainScheduler.instance)
                .map({ js -> JSObject in
                    guard let json = js["response"] as? JSObject else {
                        observer.onError(RxError.unknown)
                        observer.onCompleted()
                        return [:]
                    }
                    return json
                })
                .subscribe(onNext: { json in
                    observer.onNext(json)
                    observer.onCompleted()
                })
            return Disposables.create()
        })
    }
}
