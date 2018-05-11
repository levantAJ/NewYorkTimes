//
//  BaseServiceApiTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 11/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

@testable import NewYorkTimes
import XCTest

class APITest: XCTestCase {
    
    var sut: API!
    
    func testURL() {
        sut = .getNews(pageIndex: 0)
        XCTAssertEqual(sut.url, "https://api.nytimes.com/svc/search/v2/articlesearch.json?page=0&api-key=180e7895aa4045f5bdf78389e0cd3ec2")
        
        sut = .getNews(pageIndex: 1)
        XCTAssertEqual(sut.url, "https://api.nytimes.com/svc/search/v2/articlesearch.json?page=1&api-key=180e7895aa4045f5bdf78389e0cd3ec2")
    }
    
    func testMethod() {
        sut = .getNews(pageIndex: 0)
        XCTAssertEqual(sut.method, .get)
    }
    
}
