//
//  MappingTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 11/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

enum EnumInt: Int {
    case case0
    case case1
    case case2
}

enum EnumString: String {
    case case0 = "case0"
    case case1 = "case1"
    case case2 = "case2"
}

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
    
    func testMappingMappableObject() {
        //Given:
        let string1 = "string1"
        let string2 = "string2"
        let string3 = "string3"
        let string4 = "string4"
        
        sut = Mapping(json: ["value": [
            "object": ["string": string1],
            "array": [
                ["string": string2],
                ["string": string3],
                ["string": string4],
            ]]])
        
        //When:
        let actualObjectB: MappableObjectBMock? = sut["value"]
        
        //Then:
        XCTAssertNotNil(actualObjectB)
        guard let objectB = actualObjectB else { return }
        XCTAssertNotNil(objectB.object)
        if let objectA = objectB.object {
            XCTAssertEqual(objectA.string, string1)
        }
        XCTAssertNotNil(objectB.array)
        if let array = objectB.array {
            XCTAssertEqual(array.count, 3)
            XCTAssertEqual(array[0].string, string2)
            XCTAssertEqual(array[1].string, string3)
            XCTAssertEqual(array[2].string, string4)
        }
    }
    
    func testMappingEnumIntCase0() {
        //Given:
        sut = Mapping(json: ["enum": 0])
        
        //When
        let enumInt: EnumInt? = sut["enum"]
        
        //Then:
        XCTAssertEqual(enumInt, .case0)
    }
    
    func testMappingEnumIntCase1() {
        //Given:
        sut = Mapping(json: ["enum": 1])
        
        //When
        let enumInt: EnumInt? = sut["enum"]
        
        //Then:
        XCTAssertEqual(enumInt, .case1)
    }
    
    func testMappingEnumIntCase2() {
        //Given:
        sut = Mapping(json: ["enum": 2])
        
        //When
        let enumInt: EnumInt? = sut["enum"]
        
        //Then:
        XCTAssertEqual(enumInt, .case2)
    }
    
    func testMappingEnumStringCase0() {
        //Given:
        sut = Mapping(json: ["enum": "case0"])
        
        //When
        let enumInt: EnumString? = sut["enum"]
        
        //Then:
        XCTAssertEqual(enumInt, .case0)
    }
    
    func testMappingEnumStringCase1() {
        //Given:
        sut = Mapping(json: ["enum": "case1"])
        
        //When
        let enumInt: EnumString? = sut["enum"]
        
        //Then:
        XCTAssertEqual(enumInt, .case1)
    }
    
    func testMappingEnumStringCase2() {
        //Given:
        sut = Mapping(json: ["enum": "case2"])
        
        //When
        let enumInt: EnumString? = sut["enum"]
        
        //Then:
        XCTAssertEqual(enumInt, .case2)
    }
}
