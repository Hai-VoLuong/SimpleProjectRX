//
//  RxAPI.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/23/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift

typealias JObject = [String: Any]

class RxAPI {
    class func request(url: URL, headers: [String: String]? = nil) -> Observable<[JObject]> {
        let response = Observable.from([url])
            .map({ url -> URLRequest in
                var request = URLRequest(url: url)
                if let header = headers {
                    for (key , value) in header {
                        request.addValue(value, forHTTPHeaderField: key)
                    }
                }
                return request
            }).flatMap({ request -> Observable<(HTTPURLResponse, Data)> in
                return URLSession.shared.rx.response(request: request)
            })
            .shareReplay(1)
            .filter({ response, _ in
                return 200..<300 ~= response.statusCode
            })
            .map({ _, data -> [JObject] in
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                    let result = jsonObject as? [JObject] else {
                        return []
                    }
                return result
            })
        return response
    }
}
