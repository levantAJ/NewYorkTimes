//
//  SearchArticlesKeywordDatabaseApiTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class SearchArticlesKeywordDatabaseApiTest: XCTestCase {
    
    var sut: SearchArticlesKeywordDatabaseApi!
    var userDefaults: UserDefaultsMock!
    
    override func setUp() {
        super.setUp()
        userDefaults = UserDefaultsMock()
        sut = SearchArticlesKeywordDatabaseApi(userDefaults: userDefaults)
    }
    
}

// MARK: - Test request method

extension SearchArticlesKeywordDatabaseApiTest {
    func testRequestWhenNothingInDatabase() {
        //Given:
        let pageIndex = UInt(0)
        let pageSize = UInt(10)
        let successExpectation = self.expectation(description: #function + "success")
        let failureExpectation = self.expectation(description: #function + "failure")
        failureExpectation.isInverted = true
        let expectedKeywords: [String] = []
        userDefaults.array = expectedKeywords
        
        //When:
        sut.request(pageIndex: pageIndex, pageSize: pageSize) { (response) in
            switch response {
            case .success(let keywords):
                XCTAssertEqual(keywords, expectedKeywords)
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                failureExpectation.fulfill()
            }
        }
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func testRequestWhenKeywordsAreLessThanPageSize() {
        //Given:
        let pageIndex = UInt(0)
        let pageSize = UInt(10)
        let successExpectation = self.expectation(description: #function + "success")
        let failureExpectation = self.expectation(description: #function + "failure")
        failureExpectation.isInverted = true
        let expectedKeywords = ["Test1", "Test2", "Test3", "Test4", "Test5"]
        userDefaults.array = expectedKeywords
        
        //When:
        sut.request(pageIndex: pageIndex, pageSize: pageSize) { (response) in
            switch response {
            case .success(let keywords):
                XCTAssertEqual(keywords, expectedKeywords)
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                failureExpectation.fulfill()
            }
        }
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func testRequestWhenKeywordsAreMoreThanPageSize() {
        //Given:
        let pageIndex = UInt(0)
        let pageSize = UInt(5)
        let successExpectation = self.expectation(description: #function + "success")
        let failureExpectation = self.expectation(description: #function + "failure")
        failureExpectation.isInverted = true
        let expectedKeywords = ["Test1", "Test2", "Test3", "Test4", "Test5"]
        userDefaults.array = expectedKeywords + ["Test6", "Test7", "Test8"]
        
        //When:
        sut.request(pageIndex: pageIndex, pageSize: pageSize) { (response) in
            switch response {
            case .success(let keywords):
                XCTAssertEqual(keywords, expectedKeywords)
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                failureExpectation.fulfill()
            }
        }
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func testRequestWhenPageIndexAreMoreThanNoKeywords() {
        //Given:
        let pageIndex = UInt(1)
        let pageSize = UInt(5)
        let successExpectation = self.expectation(description: #function + "success")
        let failureExpectation = self.expectation(description: #function + "failure")
        failureExpectation.isInverted = true
        let expectedKeywords: [String] = []
        userDefaults.array = ["Test1", "Test2", "Test3", "Test4", "Test5"]
        
        //When:
        sut.request(pageIndex: pageIndex, pageSize: pageSize) { (response) in
            switch response {
            case .success(let keywords):
                XCTAssertEqual(keywords, expectedKeywords)
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                failureExpectation.fulfill()
            }
        }
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func testRequestGetFirstHaft() {
        //Given:
        let pageIndex = UInt(0)
        let pageSize = UInt(5)
        let successExpectation = self.expectation(description: #function + "success")
        let failureExpectation = self.expectation(description: #function + "failure")
        failureExpectation.isInverted = true
        let expectedKeywords = ["Test6", "Test7", "Test8", "Test9", "Test10"]
        userDefaults.array = expectedKeywords + ["Test1", "Test2", "Test3", "Test4", "Test5"]
        
        //When:
        sut.request(pageIndex: pageIndex, pageSize: pageSize) { (response) in
            switch response {
            case .success(let keywords):
                XCTAssertEqual(keywords, expectedKeywords)
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                failureExpectation.fulfill()
            }
        }
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func testRequestGetLastHaft() {
        //Given:
        let pageIndex = UInt(1)
        let pageSize = UInt(5)
        let successExpectation = self.expectation(description: #function + "success")
        let failureExpectation = self.expectation(description: #function + "failure")
        failureExpectation.isInverted = true
        let expectedKeywords = ["Test6", "Test7", "Test8", "Test9", "Test10"]
        userDefaults.array = ["Test1", "Test2", "Test3", "Test4", "Test5"] + expectedKeywords
        
        //When:
        sut.request(pageIndex: pageIndex, pageSize: pageSize) { (response) in
            switch response {
            case .success(let keywords):
                XCTAssertEqual(keywords, expectedKeywords)
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                failureExpectation.fulfill()
            }
        }
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
}

// MARK: - Test add keyword method

extension SearchArticlesKeywordDatabaseApiTest {
    func testAddKeywordWhenThereIsNoKeywordInDatabse() {
        //Given:"
        let successExpectation = self.expectation(description: #function + "success")
        let failureExpectation = self.expectation(description: #function + "failure")
        failureExpectation.isInverted = true
        let keyword = "Test1"
        let expectedKeywords = [keyword]
        userDefaults.array = []
        
        //When:
        sut.add(keyword: keyword) { (response) in
            switch response {
            case .success(let keywords):
                XCTAssertEqual(keywords, expectedKeywords)
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                failureExpectation.fulfill()
            }
        }
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func testAddKeywordWhenThereAreSomeKeywordsInDatabse() {
        //Given:"
        let successExpectation = self.expectation(description: #function + "success")
        let failureExpectation = self.expectation(description: #function + "failure")
        failureExpectation.isInverted = true
        let keyword = "Test1"
        let expectedKeywords = [keyword, "Test2", "Test3", "Test4", "Test5"]
        userDefaults.array = ["Test2", "Test3", "Test4", "Test5"]
        
        //When:
        sut.add(keyword: keyword) { (response) in
            switch response {
            case .success(let keywords):
                XCTAssertEqual(keywords, expectedKeywords)
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                failureExpectation.fulfill()
            }
        }
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
    
    func testAddKeywordWhenThereIsDuplcatedKeywordInDatabseThenShouldMoveKeywordToTheFirst() {
        //Given:"
        let successExpectation = self.expectation(description: #function + "success")
        let failureExpectation = self.expectation(description: #function + "failure")
        failureExpectation.isInverted = true
        let keyword = "Test1"
        let expectedKeywords = [keyword, "Test2", "Test3", "Test4", "Test5"]
        userDefaults.array = ["Test2", "Test3", keyword, "Test4", "Test5"]
        
        //When:
        sut.add(keyword: keyword) { (response) in
            switch response {
            case .success(let keywords):
                XCTAssertEqual(keywords, expectedKeywords)
                successExpectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                failureExpectation.fulfill()
            }
        }
        
        //Then:
        wait(for: [successExpectation, failureExpectation], timeout: 0.1)
    }
}
