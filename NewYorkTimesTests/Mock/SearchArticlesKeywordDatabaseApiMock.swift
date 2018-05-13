//
//  SearchArticlesKeywordDatabaseApiMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

@testable import NewYorkTimes

final class SearchArticlesKeywordDatabaseApiMock {
    var keyword: String?
    var pageIndex: UInt?
    var pageSize: UInt?
    var requestingCompletion: ((Response<[String]>) -> Void)?
    var addingCompletion: ((Response<[String]>) -> Void)?
}

// MARK: - SearchArticlesKeywordDatabaseApiProtocol

extension SearchArticlesKeywordDatabaseApiMock: SearchArticlesKeywordDatabaseApiProtocol {
    func request(pageIndex: UInt, pageSize: UInt, completion: @escaping (Response<[String]>) -> Void) {
        self.pageSize = pageSize
        self.pageIndex = pageIndex
        self.requestingCompletion = completion
    }
    
    func add(keyword: String, completion: ((Response<[String]>) -> Void)?) {
        self.keyword = keyword
        self.addingCompletion = completion
    }
}
