//
//  SearchArticlesKeywordDatabaseApi.swift
//  NewYorkTimes
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

protocol SearchArticlesKeywordDatabaseApiProtocol {
    func request(pageIndex: UInt, pageSize: UInt, completion: (Response<[String]>) -> Void)
    func add(keyword: String, completion: ((Response<[String]>) -> Void)?)
}

final class SearchArticlesKeywordDatabaseApi {
    fileprivate let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
}

// MARK: - SearchArticlesKeywordDatabaseApiProtocol

extension SearchArticlesKeywordDatabaseApi: SearchArticlesKeywordDatabaseApiProtocol {
    func request(pageIndex: UInt, pageSize: UInt, completion: (Response<[String]>) -> Void) {
        let lower = Int(pageIndex * pageSize)
        let upper = lower + Int(pageSize)
        let keywords = Array(getKeywords()[lower..<upper])
        completion(.success(keywords))
    }
    
    func add(keyword: String, completion: ((Response<[String]>) -> Void)? = nil) {
        let keywords = [keyword] + getKeywords()
        userDefaults.set(keywords, forKey: Constant.SearchArticlesKeywordDatabaseApi.UserDefaultsKey)
        completion?(.success(keywords))
    }
}

// MARK: - Privates

extension SearchArticlesKeywordDatabaseApi {
    fileprivate func getKeywords() -> [String] {
        return userDefaults.array(forKey: Constant.SearchArticlesKeywordDatabaseApi.UserDefaultsKey) as? [String] ?? []
    }
}

extension Constant {
    struct SearchArticlesKeywordDatabaseApi {
        static let UserDefaultsKey = "SearchArticlesKeywordDatabaseApiKey"
    }
}
