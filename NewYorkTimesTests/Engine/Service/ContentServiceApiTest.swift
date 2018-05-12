//
//  ContentServiceApiTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ContentServiceApiTest: XCTestCase {
    
    var sut: ContentServiceApi!
    var request: RequestServiceMock<ContentResponse>!
    
    override func setUp() {
        super.setUp()
        request = RequestServiceMock()
        sut = ContentServiceApi(request: request)
    }
    
    func testRequestSuccess() {
        //Given:
        let expectation = XCTestExpectation(description: #function)
        let expectedContent = Content()
        let contentResponse = ContentResponse(status: .ok, contents: [expectedContent])
        
        //When:
        sut.request(pageIndex: 0, pageSize: 0) { response in
            switch response {
            case .success(let value):
                XCTAssertEqual(value.count, 1)
                if let content = value.first {
                    XCTAssertEqual(expectedContent, content)
                }
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        request.objectCompletion?(.success(contentResponse))
        
        //Then:
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testRequestFailureCannotReachServer() {
        //Given:
        let expectation = XCTestExpectation(description: #function)
        let contentResponse = ContentResponse(status: .unknown, contents: [])
        
        //When:
        sut.request(pageIndex: 0, pageSize: 0) { response in
            switch response {
            case .success(let value):
                XCTAssertNil(value)
            case .failure(let error):
                XCTAssertEqual(APIError.serverError.error, error as NSError)
            }
            expectation.fulfill()
        }
        request.objectCompletion?(.success(contentResponse))
        
        //Then:
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testRequestFailure() {
        //Given:
        let expectation = XCTestExpectation(description: #function)
        let expectedError = NSError(domain: "test-error", code: 0, userInfo: [:])
        
        //When:
        sut.request(pageIndex: 0, pageSize: 0) { response in
            switch response {
            case .success(let value):
                XCTAssertNil(value)
            case .failure(let error):
                XCTAssertEqual(expectedError, error as NSError)
            }
            expectation.fulfill()
        }
        request.objectCompletion?(.failure(expectedError))
        
        //Then:
        wait(for: [expectation], timeout: 0.1)
    }
}
