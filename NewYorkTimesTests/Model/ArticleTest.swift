//
//  ArticleTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ArticleTest: XCTestCase {
    
    var sut: Article!
    
    override func setUp() {
        super.setUp()
        sut = Article()
    }
}

// MARK: - Test mapping method

extension ArticleTest {
    
    func testMapping() {
        //Given:
        let snippet = "LEAD: Textron Inc. reported today that its third-quarter earnings increased nearly 12 percent, largely on improvements in its aerospace business."
        let title = "Textron Posts Gain in Profits"
        let webURL = "https://www.nytimes.com/1990/10/19/business/textron-posts-gain-in-profits.html"
        let map = Mapping(json: [
            "snippet": snippet,
            "headline": [
                "main": title,
            ],
            "web_url": webURL
            ])
        
        //When:
        sut.mapping(map: map)
        
        //Then:
        XCTAssertEqual(sut.snippet, snippet)
        XCTAssertEqual(sut.title, title)
        XCTAssertEqual(sut.webURL?.absoluteString, webURL)
    }
}
