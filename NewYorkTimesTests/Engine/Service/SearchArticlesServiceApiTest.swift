//
//  SearchArticlesServiceApiTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class SearchArticlesServiceApiTest: XCTestCase {
    
    var sut: SearchArticlesServiceApi!
    var request: RequestServiceMock<SearchArticlesResponse>!
    
    override func setUp() {
        super.setUp()
        request = RequestServiceMock()
        sut = SearchArticlesServiceApi(request: request)
    }
}

// MARK: - Test search method

extension SearchArticlesServiceApiTest {
    func testSearchSuccess() {
        //Given:
        let query = "query"
        let pageIndex = UInt(0)
        let successExpectation = expectation(description: #function + "success")
        let failureExpectation = expectation(description: #function + "failure")
        failureExpectation.isInverted = true
        let article = Article(snippet: "snippet", title: "title", webURL: URL(string: "https://www.nytimes.com/1990/10/19/business/textron-posts-gain-in-profits.html"))
        let expectedArticles = [article, article, article]
        let response = SearchArticlesResponse(status: .ok, articles: expectedArticles)
        
        //When:
        sut.search(query: query, pageIndex: pageIndex) { (response) in
            switch response {
            case .success(let articles):
                XCTAssertEqual(articles, expectedArticles)
                successExpectation.fulfill()
            case .failure:
                failureExpectation.fulfill()
            }
        }
        request.objectCompletion?(.success(response))
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func testSearchFailureBecauseCannotReachToTheServer() {
        //Given:
        let query = "query"
        let pageIndex = UInt(0)
        let successExpectation = expectation(description: #function + "success")
        successExpectation.isInverted = true
        let failureExpectation = expectation(description: #function + "failure")
        let article = Article(snippet: "snippet", title: "title", webURL: URL(string: "https://www.nytimes.com/1990/10/19/business/textron-posts-gain-in-profits.html"))
        let expectedArticles = [article, article, article]
        let response = SearchArticlesResponse(status: .unknown, articles: expectedArticles)
        
        //When:
        sut.search(query: query, pageIndex: pageIndex) { (response) in
            switch response {
            case .success:
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(APIError.serverError.error, error as NSError)
                failureExpectation.fulfill()
            }
        }
        request.objectCompletion?(.success(response))
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func testSearchFailure() {
        //Given:
        let query = "query"
        let pageIndex = UInt(0)
        let successExpectation = expectation(description: #function + "success")
        successExpectation.isInverted = true
        let failureExpectation = expectation(description: #function + "failure")
        let expectedError = NSError(domain: "test-error", code: 0, userInfo: [:])
        
        //When:
        sut.search(query: query, pageIndex: pageIndex) { (response) in
            switch response {
            case .success:
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(expectedError, error as NSError)
                failureExpectation.fulfill()
            }
        }
        request.objectCompletion?(.failure(expectedError))
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
}
