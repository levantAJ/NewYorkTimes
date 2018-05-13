//
//  SearchArticlesServiceApiMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

@testable import NewYorkTimes

final class SearchArticlesServiceApiMock {
    var query: String?
    var pageIndex: UInt?
    var completion: ((Response<[Article]>) -> Void)?
}

// MARK: - SearchArticlesServiceApiProtocol

extension SearchArticlesServiceApiMock: SearchArticlesServiceApiProtocol {
    func search(query: String, pageIndex: UInt, completion: @escaping (Response<[Article]>) -> Void) {
        self.query = query
        self.pageIndex = pageIndex
        self.completion = completion
    }
}
