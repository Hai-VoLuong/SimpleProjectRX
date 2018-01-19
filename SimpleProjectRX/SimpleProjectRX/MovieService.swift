//
//  MovieService.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/19/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

typealias CurrentWeatherCompletionHandler = (Result<[Movie?]>) -> Void

protocol Gettable {
    associatedtype T
    func get(completion: @escaping (Result<T>) -> Void)
}

struct MovieService: Gettable {
    let endpoint: String = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
    let downloader = JSONDownloader()

    func get(completion: @escaping CurrentWeatherCompletionHandler) {
        guard let url = URL(string: self.endpoint) else {
            completion(Result.error(ItunesApiError.invalidURL))
            return
        }

        let request = URLRequest(url: url)

        let task = downloader.jsonTask(with: request, completionHandler: { result in
            DispatchQueue.main.async {
                switch result {
                case .error(let error):
                    completion(Result.error(error))
                case .success(let json):
                    guard let movieJSONFeed = json["feed"] as? [String: AnyObject],
                        let entryArray = movieJSONFeed["entry"] as? [[String: AnyObject]] else {
                            completion(Result.error(ItunesApiError.jsonParsingFailure))
                            return
                    }
                    let movieArray = entryArray.map { Movie(json: $0) }
                    completion(Result.success(movieArray))
                }
            }
        })
        task.resume()
    }
}
