//
//  BookService.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/10/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import RxSwift

class BookService: BaseService {

    // Theo cách thông thường
    static func getBook(id: Int, completion: @escaping (Event?, Error?) -> Void) {
        requestJson(api: .getBook(id), completion: { (json, error) in
            if let error = error {
                completion(nil, error)
            } else if let book = Event(JSON: json!) {
                completion(Event(JSON: json!), nil)
            } else {
                completion(nil, APIError.invalidURL(url: ""))
               // completion(nil, ResponseError.invalidJSONFormat)
            }
        })
    }

    // Sử dụng RxSwift
    static func getBookRx(id: Int) -> Observable<Event> {
        return requestJsonRx(api: .getBook(id)).map({ json in
            if let book = Event(JSON: json) {
                return book
            } else {
                throw APIError.invalidURL(url: "")
                // throw ResponseError.invalidJSONFormat
            }
        })
    }
}
