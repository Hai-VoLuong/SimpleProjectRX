//
//  API.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/10/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import Moya

enum API {

    case getBook(Int)
    // ... more APIs
}

extension API: TargetType {

    static let baseUrl = "http://localhost:3000"
    static let apiVersion = "/api/v1"

    var baseURL: URL {
        return URL(string: API.baseUrl + API.apiVersion)!
    }

    var path: String {
        switch self {
        case .getBook(let id):
            return "/books/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getBook:
            return .get
        }
    }

    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }

    var task: Task {
        switch self {
        case .getBook:
            return Task.requestPlain
        }
    }

    var headers: [String : String]? {
        return nil
    }
}
