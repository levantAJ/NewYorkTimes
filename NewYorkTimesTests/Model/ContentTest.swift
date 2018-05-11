//
//  ContentTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 11/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ContentTest: XCTestCase {
    
    var sut: Content!
    
    override func setUp() {
        super.setUp()
        sut = Content()
    }
    
    func testMapping() {
        //Given:
        let title = "Review: 50 Violins, 50 Computer Chips, a Secular Prayer"
        let abstract = "Tristan Perich’s sublime “Drift Multiply” shared the program at the Cathedral Church of St. John the Divine with Lesley Flanigan’s “Subtonalities.”"
        let url = "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"
        let thumbnailStandard = "https://static01.nyt.com/images/2018/05/12/arts/12perich1/12perich1-thumbStandard.jpg"
        let publishedDate = "2018-05-10T20:00:00-04:00"
        let mapping = Mapping(json: [
            "title": title,
            "abstract": abstract,
            "url": url,
            "thumbnail_standard": thumbnailStandard,
            "published_date": publishedDate
            ])
        
        //When:
        sut.mapping(map: mapping)
        
        //Then:
        XCTAssertEqual(sut.title, title)
        XCTAssertEqual(sut.abstract, abstract)
        XCTAssertNotNil(sut.url)
        if let absoluteString = sut.url?.absoluteString {
            XCTAssertEqual(absoluteString, url)
        }
        XCTAssertNotNil(sut.imageURL)
        if let absoluteString = sut.imageURL?.absoluteString {
            XCTAssertEqual(absoluteString, thumbnailStandard)
        }
        XCTAssertNotNil(sut.date)
    }
    
}
