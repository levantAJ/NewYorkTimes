//
//  SearchArticlesResponseTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class SearchArticlesResponseTest: XCTestCase {
    
    var sut: SearchArticlesResponse!
    
    override func setUp() {
        super.setUp()
        sut = SearchArticlesResponse()
    }
}

// MARK: - Test mapping method

extension SearchArticlesResponseTest {
    func testMapping() {
        //Given:
        let snippet = "LEAD: Textron Inc. reported today that its third-quarter earnings increased nearly 12 percent, largely on improvements in its aerospace business."
        let title = "Textron Posts Gain in Profits"
        let webURL = "https://www.nytimes.com/1990/10/19/business/textron-posts-gain-in-profits.html"
        let articleJSON: [String: Any] = [
            "snippet": snippet,
            "headline": [
                "main": title,
            ],
            "web_url": webURL
        ]
        
        let map = Mapping(json: [
            "status": "OK",
            "response": [
                "docs": [articleJSON, articleJSON, articleJSON],
            ],
            ])
        
        //When:
        sut.mapping(map: map)
        
        //Then:
        XCTAssertEqual(sut.status, .ok)
        XCTAssertEqual(sut.articles?.count, 3)
        if sut.articles?.count == 3 {
            XCTAssertEqual(sut.articles?[0].snippet, snippet)
            XCTAssertEqual(sut.articles?[0].title, title)
            XCTAssertEqual(sut.articles?[0].webURL?.absoluteString, webURL)
            
            XCTAssertEqual(sut.articles?[1].snippet, snippet)
            XCTAssertEqual(sut.articles?[1].title, title)
            XCTAssertEqual(sut.articles?[1].webURL?.absoluteString, webURL)
            
            XCTAssertEqual(sut.articles?[2].snippet, snippet)
            XCTAssertEqual(sut.articles?[2].title, title)
            XCTAssertEqual(sut.articles?[2].webURL?.absoluteString, webURL)
        }
    }
}
