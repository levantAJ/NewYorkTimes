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
        let thumbnailImageURL = "https://static01.nyt.com/images/2018/05/12/arts/12perich1/12perich1-thumbStandard.jpg"
        let publishedDate = "2018-05-10T20:00:00-04:00"
        let source = "The New York Times"
        let byline = "By KALY SOTO"
        let mapping = Mapping(json: [
            "title": title,
            "abstract": abstract,
            "url": url,
            "thumbnail_standard": thumbnailImageURL,
            "published_date": publishedDate,
            "source": source,
            "byline": byline,
            "multimedia":[
                ["url": url,
                "type": "",
                "format": "mediumThreeByTwo210"],
                ["url": url,
                 "type": "image",
                 "format": "Normal"],
            ]])
        
        //When:
        sut.mapping(map: mapping)
        
        //Then:
        XCTAssertEqual(sut.title, title)
        XCTAssertEqual(sut.abstract, abstract)
        XCTAssertEqual(sut.byline, byline)
        XCTAssertEqual(sut.source, source)
        XCTAssertNotNil(sut.url)
        if let absoluteString = sut.url?.absoluteString {
            XCTAssertEqual(absoluteString, url)
        }
        XCTAssertNotNil(sut.thumbnailImageURL)
        if let absoluteString = sut.thumbnailImageURL?.absoluteString {
            XCTAssertEqual(absoluteString, thumbnailImageURL)
        }
        XCTAssertNotNil(sut.date)
        XCTAssertNotNil(sut.multimedias)
        if let multimedias = sut.multimedias {
            XCTAssertEqual(multimedias.count, 2)
            XCTAssertEqual(multimedias[0].url?.absoluteString, url)
            XCTAssertEqual(multimedias[0].type, .unknown)
            XCTAssertEqual(multimedias[0].format, .mediumThreeByTwo210)
            XCTAssertEqual(multimedias[1].url?.absoluteString, url)
            XCTAssertEqual(multimedias[1].type, .image)
            XCTAssertEqual(multimedias[1].format, .normal)
        }
    }
    
}
