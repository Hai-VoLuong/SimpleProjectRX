//
//  ResponseError.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/9/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

enum ResponseError: Error {
    case noStatusCode
    case invalidData(data: Any)

    case unknown(statusCode: Int)
    case notModified // 304
    case invalidRequest // 400
    case unauthorized // 401
    case accessDenied // 403
    case notFound  // 404
    case methodNotAllowed  // 405
    case validate   // 422
    case serverError // 500
    case badGateway // 502
    case serviceUnavailable // 503
    case gatewayTimeout // 504
}
