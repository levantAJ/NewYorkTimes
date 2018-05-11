//
//  MappingTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 11/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class MappingTest: XCTestCase {
    
    var sut: Mapping!
    
    func testMappingString() {
        sut = Mapping(json: ["key": "value"])
        XCTAssertEqual(sut["key"], "value")
    }
    
    func testMappingURL() {
        //Given:
        let expectedAbsoluteString = "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"
        sut = Mapping(json: ["url": expectedAbsoluteString])
        
        //When:
        let url: URL? = sut["url"]
        XCTAssertNotNil(url)
        guard let absoluteString = url?.absoluteString else { return }
        XCTAssertEqual(absoluteString, expectedAbsoluteString)
    }
    
    func testMappingDateWithIOS8601CombinedDateAndTimeDateFormat() {
        //Given:
        let expectedDateString = "2018-04-10T04:11:29-00:00"
        sut = Mapping(json: ["date": expectedDateString])
        
        //When:
        XCTAssertNotNil(sut["date", .iso8601CombinedDateAndTime])
    }
    
    func testMappingDateWithIOS8601DateDateFormat() {
        //Given:
        let expectedDateString = "2018-04-10"
        sut = Mapping(json: ["date": expectedDateString])
        
        //When:
        XCTAssertNotNil(sut["date", .iso8601Date])
    }
    
    func testMappingDateWithCustomDateFormat() {
        //Given:
        let expectedDateString = "04/10/2017"
        sut = Mapping(json: ["date": expectedDateString])
        
        //When:
        XCTAssertNotNil(sut["date", .custom(format: "dd/MM/yyyy")])
    }
}
