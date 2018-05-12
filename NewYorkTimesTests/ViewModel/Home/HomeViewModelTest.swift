//
//  HomeViewModelTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class HomeViewModelTest: XCTestCase {
    
    var sut: HomeViewModel!
    var contentSerivce: ContentServiceApiMock!
    
    override func setUp() {
        super.setUp()
        contentSerivce = ContentServiceApiMock()
        sut = HomeViewModel(contentSerivce: contentSerivce)
    }
    
    func testRefreshSuccess() {
        //Given:
        let content = mockedContent()
        let succeedExpectation = XCTestExpectation(description: #function + "onReloadData")
        sut.onReloadData = {
            succeedExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        erroredExpectation.isInverted = true
        sut.onError = { _ in
            erroredExpectation.fulfill()
        }
        
        //When:
        sut.refresh()
        contentSerivce.completion?(.success([content]))
        
        //Then:
        XCTAssertEqual(contentSerivce.pageIndex, 0)
        XCTAssertEqual(contentSerivce.pageSize, Constant.API.PageSize)
        wait(for: [succeedExpectation, erroredExpectation], timeout: 0.1)
    }
    
    func testRefreshError() {
        //Given:
        let message = "Error message"
        let expectedError = mockedError(message: message)
        let succeedExpectation = XCTestExpectation(description: #function + "onReloadData")
        succeedExpectation.isInverted = true
        sut.onReloadData = {
            succeedExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        sut.onError = { errorMessage in
            XCTAssertEqual(errorMessage, message)
            erroredExpectation.fulfill()
        }
        
        //When:
        sut.refresh()
        contentSerivce.completion?(.failure(expectedError))
        
        //Then:
        XCTAssertEqual(contentSerivce.pageIndex, 0)
        XCTAssertEqual(contentSerivce.pageSize, Constant.API.PageSize)
        wait(for: [succeedExpectation, erroredExpectation], timeout: 0.1)
    }
    
    func testLoadMoreSuccess() {
        //TODO:
    }
    
    func testNumberOfRows () {
        //TODO:
    }
    
    func testContentAtIndex() {
        //TODO:
    }
    
}

// MARK: - Privates

extension HomeViewModelTest {
    fileprivate func mockedContent() -> Content {
        return Content(title: "title", abstract: "abstract", url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html")!, thumbnailImageURL: URL(string: "https://static01.nyt.com/images/2018/05/12/arts/12perich1/12perich1-thumbStandard.jpg")!, date: Date(), multimedias: [
            Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image)
            ])
    }
    
    fileprivate func mockedError(message: String) -> Error {
        return NSError(domain: "test-error", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}