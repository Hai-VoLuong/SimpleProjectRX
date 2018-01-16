//
//  GithubService.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/16/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

enum Result<T> {
    case error(Error)
    case success(T)
}

enum ServiceError: Error {
    case cannotParse
}

class GithubService {
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func getLangueList(completionHandle: (Result<[String]>) -> Void) {
        let stubbedListOfPopularLanguages = ["Swift","Objective-C","Java","C","C++","Python","C#"]
        completionHandle(.success(stubbedListOfPopularLanguages))
    }

    func getMostPopularRepositories(byLanguge language: String, completionHandler: @escaping(Result<[RepositoryMedium]>) -> Void) {
        let encodedLanguage = language.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        let url = URL(string: "https://api.github.com/search/repositories?q=language:\(encodedLanguage)&sort=stars")!

        session.dataTask(with: url) {data, reponse, error in
            DispatchQueue.main.async {
                if let error = error {
                    completionHandler(.error(error))
                    return
                }
                guard let data = data,
                    let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                    let jsonDict = jsonObject as? [String: Any],
                    let itemJson = jsonDict["item"] as? [[String: Any]] else {
                        completionHandler(.error(ServiceError.cannotParse))
                        return
                }
                let repositories = itemJson.flatMap(RepositoryMedium.init)
                completionHandler(.success(repositories))
            }
        }
    }

}
