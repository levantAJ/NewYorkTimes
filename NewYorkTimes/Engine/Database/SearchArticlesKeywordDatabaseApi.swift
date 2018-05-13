//
//  SearchArticlesKeywordDatabaseApi.swift
//  NewYorkTimes
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

protocol UserDefaultsProtocol {
    func array(forKey defaultName: String) -> [Any]?
    func set(_ value: Any?, forKey defaultName: String)
}

protocol SearchArticlesKeywordDatabaseApiProtocol {
    func request(pageIndex: UInt, pageSize: UInt, completion: @escaping (Response<[String]>) -> Void)
    func add(keyword: String, completion: ((Response<[String]>) -> Void)?)
}

final class SearchArticlesKeywordDatabaseApi {
    fileprivate let userDefaults: UserDefaultsProtocol
    
    init(userDefaults: UserDefaultsProtocol) {
        self.userDefaults = userDefaults
    }
}

// MARK: - SearchArticlesKeywordDatabaseApiProtocol

extension SearchArticlesKeywordDatabaseApi: SearchArticlesKeywordDatabaseApiProtocol {
    func request(pageIndex: UInt, pageSize: UInt, completion: @escaping (Response<[String]>) -> Void) {
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }
            let keywords = strongSelf.getKeywords()
            let lower = Int(pageIndex * pageSize)
            let pagedKeywords: [String]
            if lower >= keywords.count {
                pagedKeywords = []
            } else {
                let upper = min(lower + Int(pageSize), keywords.count)
                pagedKeywords = Array(keywords[lower..<upper])
            }
            DispatchQueue.main.async {
                completion(.success(pagedKeywords))
            }
        }
    }
    
    func add(keyword: String, completion: ((Response<[String]>) -> Void)? = nil) {
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }
            var keywords = strongSelf.getKeywords()
            if let index = keywords.index(of: keyword) {
                keywords.remove(at: index)
            }
            keywords = [keyword] + keywords
            strongSelf.userDefaults.set(keywords, forKey: Constant.SearchArticlesKeywordDatabaseApi.UserDefaultsKey)
            DispatchQueue.main.async {
                completion?(.success(keywords))
            }
        }
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
