//
//  MultimediaTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class MultimediaTest: XCTestCase {
    
    var sut: Multimedia!
    
    override func setUp() {
        super.setUp()
        sut = Multimedia()
    }
    
    func testMapping() {
        //Given:
        let url = "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"
        let json = [
            "url": url,
            "type": "image",
            "format": "Standard Thumbnail"
        ]
        
        //When:
        let mapping = Mapping(json: json)
        sut.mapping(map: mapping)
        
        //Then:
        XCTAssertEqual(sut.url?.absoluteString, url)
        XCTAssertEqual(sut.type, .image)
        XCTAssertEqual(sut.format, .standardThumbnail)
    }
    
    func testMappingTypeShouldBeUnknown() {
        //Given:
        let url = "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"
        let json = [
            "url": url,
            "type": "something",
            "format": "Standard Thumbnail"
        ]
        
        //When:
        let mapping = Mapping(json: json)
        sut.mapping(map: mapping)
        
        //Then:
        XCTAssertEqual(sut.url?.absoluteString, url)
        XCTAssertEqual(sut.type, .unknown)
        XCTAssertEqual(sut.format, .standardThumbnail)
    }
    
    func testMappingFormatShouldBeUnknown() {
        //Given:
        let url = "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"
        let json = [
            "url": url,
            "type": "something",
            "format": "something"
        ]
        
        //When:
        let mapping = Mapping(json: json)
        sut.mapping(map: mapping)
        
        //Then:
        XCTAssertEqual(sut.url?.absoluteString, url)
        XCTAssertEqual(sut.type, .unknown)
        XCTAssertEqual(sut.format, .unknown)
    }
}
