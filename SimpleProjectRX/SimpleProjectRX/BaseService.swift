//
//  BaseService.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/10/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import RxSwift

//class ResponseError {
//
//    static let invalidJSONFormat = NSError(domain: "", code: 600, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON Format"])
//}

class BaseService {

    // Cách thông thường
    static func requestJson(api: API, completion: @escaping ([String: Any]?, Error?) -> Void) {
        APIProvider.shared.request(api) { result in
            do {
                switch result {
                case .success(let response):
                    let json = try response.mapJSON()
                    if let jsonDict = json as? [String: Any] {
                        completion(jsonDict, nil)
                    } else {
                        // throw ResponseError.invalidJSONFormat
                    }
                case .failure(let error):
                    throw error
                }
            } catch {
                completion(nil, error)
            }
        }
    }

    // Sử dụng RxSwift
    static func requestJsonRx(api: API) -> Observable<[String: Any]> {
        return Observable.create({ observer -> Disposable in
            let request = APIProvider.shared.request(api, completion: { result in
                do {
                    switch result {
                    case .success(let response):
                        let json = try response.mapJSON()
                        if let jsonDict = json as? [String: Any] {
                            observer.onNext(jsonDict)
                        } else {
                           // throw ResponseError.invalidJSONFormat
                        }
                    case .failure(let error):
                        throw error
                    }
                } catch let error {
                    observer.onError(error)
                }
            })
            return Disposables.create {
                request.cancel()
            }
        })
    }
}

