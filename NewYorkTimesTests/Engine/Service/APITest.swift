//
//  BaseServiceApiTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 11/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class APITest: XCTestCase {
    
    var sut: API!
    
    func testURLForGetArticlesAPI() {
        sut = .getContents(pageIndex: 0, pageSize: 10)
        XCTAssertEqual(sut.url.absoluteString, "https://api.nytimes.com/svc/news/v3/content/all/all.json?limit=10&offset=0&api-key=180e7895aa4045f5bdf78389e0cd3ec2")
        
        sut = .getContents(pageIndex: 1, pageSize: 10)
        XCTAssertEqual(sut.url.absoluteString, "https://api.nytimes.com/svc/news/v3/content/all/all.json?limit=10&offset=10&api-key=180e7895aa4045f5bdf78389e0cd3ec2")
    }
    
    func testMethodForGetArticlesAPI() {
        sut = .getContents(pageIndex: 0, pageSize: 10)
        XCTAssertEqual(sut.method, .get)
    }

    func testURLForSearchArticlesAPI() {
        sut = .searchArticles(query: "", pageIndex: 0)
        XCTAssertEqual(sut.url.absoluteString, "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=&page=0&api-key=180e7895aa4045f5bdf78389e0cd3ec2")
        
        sut = .searchArticles(query: "hello world", pageIndex: 1)
        XCTAssertEqual(sut.url.absoluteString, "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=hello%20world&page=1&api-key=180e7895aa4045f5bdf78389e0cd3ec2")
    }
    
    func testMethodForSearchArticlesAPI() {
        sut = .searchArticles(query: "", pageIndex: 0)
        XCTAssertEqual(sut.method, .get)
    }
    
}
