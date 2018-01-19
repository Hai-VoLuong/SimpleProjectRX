//
//  JSONDownloader.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/19/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

enum ItunesApiError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case invalidURL
    case jsonParsingFailure
}

typealias JSON = [String: AnyObject]
typealias JSONTaskCompletionHandler = (Result<JSON>) -> ()

struct JSONDownloader {

    let session: URLSession

    private init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(Result.error(ItunesApiError.requestFailed))
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                            DispatchQueue.main.async {
                                completion(Result.success(json))
                            }
                        }
                    } catch {
                        completion(Result.error(ItunesApiError.jsonParsingFailure))
                    }
                } else {
                    completion(Result.error(ItunesApiError.invalidData))
                }
            } else {
                completion(Result.error(ItunesApiError.responseUnsuccessful))
                print("Error :\(error?.localizedDescription)")
            }
        }
        return task
    }

}

