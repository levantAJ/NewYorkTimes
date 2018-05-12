//
//  RequestServiceTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class RequestServiceTest: XCTestCase {
    
    var sut: RequestService!
    var session: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        session = URLSessionMock()
        sut = RequestService(session: session)
    }
    
    func testObjectSuccess() {
        //Given:
        let api: API = .getContents(pageIndex: 0, pageSize: 0)
        let expectation = XCTestExpectation(description: #function)
        let json = [
            "object": ["string": "string1"],
            "array": [
                ["string": "string2"],
                ["string": "string3"],
                ["string": "string4"],
            ]] as [String : Any]
        let data = try! JSONSerialization.data(withJSONObject: json)
        let completion: (Response<MappableObjectBMock>) -> Void = { (response) in
            switch response {
            case .success(let value):
                XCTAssertNotNil(value)
                XCTAssertEqual(value.object?.string, "string1")
                XCTAssertEqual(value.array?.count, 3)
                if (value.array?.count == 3) {
                    XCTAssertEqual(value.array?[0].string, "string2")
                    XCTAssertEqual(value.array?[1].string, "string3")
                    XCTAssertEqual(value.array?[2].string, "string4")
                }
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        
        //When:
        sut.object(from: api, completion: completion)
        session.completion?(data, nil, nil)
        
        //Then:
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testObjectCannotMapping() {
        //Given:
        let api: API = .getContents(pageIndex: 0, pageSize: 0)
        let expectation = XCTestExpectation(description: #function)
        let json = [:] as [String : Any]
        let data = try! JSONSerialization.data(withJSONObject: json)
        let completion: (Response<MappableObjectBMock>) -> Void = { (response) in
            switch response {
            case .success(let value):
                XCTAssertNil(value.object)
                XCTAssertNil(value.array)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        //When:
        sut.object(from: api, completion: completion)
        session.completion?(data, nil, nil)
        
        //Then:
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testObjectFailureWithError() {
        //Given:
        let api: API = .getContents(pageIndex: 0, pageSize: 0)
        let expectation = XCTestExpectation(description: #function)
        let expectedError = NSError(domain: "test-error", code: 0, userInfo: [:])
        let completion: (Response<MappableObjectBMock>) -> Void = { (response) in
            switch response {
            case .success(let value):
                XCTAssertNil(value)
            case .failure(let error):
                XCTAssertEqual(expectedError, error as NSError)
            }
            expectation.fulfill()
        }
        
        //When:
        sut.object(from: api, completion: completion)
        session.completion?(nil, nil, expectedError)
        
        //Then:
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testArraySuccess() {
        //Given:
        let api: API = .getContents(pageIndex: 0, pageSize: 0)
        let expectation = XCTestExpectation(description: #function)
        let json = [[
            "object": ["string": "string1"],
            "array": [
                ["string": "string2"],
                ["string": "string3"],
                ["string": "string4"],
            ]]]
        let data = try! JSONSerialization.data(withJSONObject: json)
        let completion: (Response<[MappableObjectBMock]>) -> Void = { (response) in
            switch response {
            case .success(let value):
                XCTAssertEqual(value.count, 1)
                if (value.count == 1) {
                    XCTAssertEqual(value[0].object?.string, "string1")
                    XCTAssertEqual(value[0].array?.count, 3)
                    if (value[0].array?.count == 3) {
                        XCTAssertEqual(value[0].array?[0].string, "string2")
                        XCTAssertEqual(value[0].array?[1].string, "string3")
                        XCTAssertEqual(value[0].array?[2].string, "string4")
                    }
                }
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        
        //When:
        sut.array(from: api, completion: completion)
        session.completion?(data, nil, nil)
        
        //Then:
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testArrayCannotMapping() {
        //Given:
        let api: API = .getContents(pageIndex: 0, pageSize: 0)
        let expectation = XCTestExpectation(description: #function)
        let json = [[:]]
        let data = try! JSONSerialization.data(withJSONObject: json)
        let completion: (Response<[MappableObjectBMock]>) -> Void = { (response) in
            switch response {
            case .success(let value):
                XCTAssertEqual(value.count, 1)
                if (value.count == 1) {
                    XCTAssertNil(value[0].object)
                    XCTAssertNil(value[0].array)
                }
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        //When:
        sut.array(from: api, completion: completion)
        session.completion?(data, nil, nil)

        //Then:
        wait(for: [expectation], timeout: 0.1)
    }

    func testArrayFailureWithError() {
        //Given:
        let api: API = .getContents(pageIndex: 0, pageSize: 0)
        let expectation = XCTestExpectation(description: #function)
        let expectedError = NSError(domain: "test-error", code: 0, userInfo: [:])
        let completion: (Response<[MappableObjectBMock]>) -> Void = { (response) in
            switch response {
            case .success(let value):
                XCTAssertNil(value)
            case .failure(let error):
                XCTAssertEqual(expectedError, error as NSError)
            }
            expectation.fulfill()
        }
        
        //When:
        sut.array(from: api, completion: completion)
        session.completion?(nil, nil, expectedError)

        //Then:
        wait(for: [expectation], timeout: 0.1)
    }
}
