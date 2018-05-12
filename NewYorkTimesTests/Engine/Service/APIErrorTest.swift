//
//  APIErrorTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class APIErrorTest: XCTestCase {
    
    var sut: APIError!
    
    func testCode() {
        sut = .unexpected
        XCTAssertEqual(sut.code, -1)
        
        sut = .mapping
        XCTAssertEqual(sut.code, -2)
        
        sut = .serverError
        XCTAssertEqual(sut.code, -3)
    }
    
    func testDescription() {
        sut = .unexpected
        XCTAssertEqual(sut.description, "Unexpected error")
        
        sut = .mapping
        XCTAssertEqual(sut.description, "Cannot mapping object")
        
        sut = .serverError
        XCTAssertEqual(sut.description, "Cannot connect to server")
    }
    
    func testError() {
        sut = .unexpected
        XCTAssertEqual(sut.error.code, -1)
        XCTAssertEqual(sut.error.localizedDescription, "Unexpected error")
        
        sut = .mapping
        XCTAssertEqual(sut.error.code, -2)
        XCTAssertEqual(sut.error.localizedDescription, "Cannot mapping object")
        
        sut = .serverError
        XCTAssertEqual(sut.error.code, -3)
        XCTAssertEqual(sut.error.localizedDescription, "Cannot connect to server")
    }
}
