//
//  ArticleRepository.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/10/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation

class Article {

}
protocol ArticleRepository {

    // associatedtype T

    func getAll() -> [Article]
    func get( identifier:Int ) -> Article?
    func create( article:Article ) -> Bool
    func update( article:Article ) -> Bool
    func delete( article:Article ) -> Bool
}

class WebArticleRepository: ArticleRepository {
    func getAll() -> [Article] {
        // API code
        return [Article]()
    }

    func get(identifier: Int) -> Article? {
        // API code
        return Article()
    }

    func create(article: Article) -> Bool {
        // API code
        return true
    }

    func update(article: Article) -> Bool {
        // API code
        return true
    }

    func delete(article: Article) -> Bool {
        // API code
        return true
    }
}
class LocalArticleRepository: ArticleRepository {

    func getAll() -> [Article] {
        // API code
        return [Article]()
    }

    func get(identifier: Int) -> Article? {
        // API code
        return Article()
    }

    func create(article: Article) -> Bool {
        // API code
        return true
    }

    func update(article: Article) -> Bool {
        // API code
         return true
    }

    func delete(article: Article) -> Bool {
        // API code
         return true
    }
}

class MockArticleRepository: ArticleRepository {

    func getAll() -> [Article] {
        // Return mock data
        return [Article]()
    }

    func get(identifier: Int) -> Article? {
        // Return mock data
        return Article()
    }

    func create(article: Article) -> Bool {
        // Return mock data
        return true
    }

    func update(article: Article) -> Bool {
        // Return mock data
        return true
    }

    func delete(article: Article) -> Bool {
        // Return mock data
        return true
    }
}

class ArticleFeedViewModel {
    let articleRepo: ArticleRepository

    init( articleRepo: ArticleRepository = WebArticleRepository() ) {
        self.articleRepo = articleRepo
    }
}

class main {
    func viewDidLoad() {
        let webArticleRepo = WebArticleRepository()
        webArticleRepo.getAll()

        let localArticleRepo = LocalArticleRepository()
        localArticleRepo.getAll()
    }
}

class unitTest {
    let mockRepo = MockArticleRepository()

    func testViewModel() {
        let viewModelUnderTest = ArticleFeedViewModel( articleRepo: mockRepo )
    }
}





