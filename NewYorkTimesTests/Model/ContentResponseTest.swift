//
//  ContentResponseTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ContentResponseTest: XCTestCase {
    
    var sut: ContentResponse!
    
    override func setUp() {
        super.setUp()
        sut = ContentResponse()
    }
    
    func testMapping() {
        //Given:
        let mapping = Mapping(json: [
            "status": "OK",
            "results": [
                ["title": "title",
                 "abstract": "abstract",
                 "url": "url",
                 "thumbnail_standard": "thumbnailImageURL",
                 "published_date": "publishedDate",
                 "multimedia":[
                    ["url": "url",
                     "type": "",
                     "format": "mediumThreeByTwo210"],
                    ["url": "url",
                     "type": "image",
                     "format": "Normal"],
                    ]]]])
        
        //When:
        sut.mapping(map: mapping)
        
        //Then
        XCTAssertEqual(sut.status, .ok)
        XCTAssertEqual(sut.contents.count, 1)
        if sut.contents.count == 1 {
            XCTAssertEqual(sut.contents[0].title, "title")
            XCTAssertEqual(sut.contents[0].abstract, "abstract")
        }
    }
    
}
