//
//  SearchArticlesKeywordResultsCollectionViewCellViewModelTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class SearchArticlesKeywordResultsCollectionViewCellViewModelTest: XCTestCase {
    
    var sut: SearchArticlesKeywordResultsCollectionViewCellViewModel!
    var keyword: String!
    
    override func setUp() {
        super.setUp()
        keyword = "NewYorkTimes"
        sut = SearchArticlesKeywordResultsCollectionViewCellViewModel(keyword: keyword)
    }
    
    func testTitle() {
        XCTAssertEqual(sut.title, keyword)
    }
}
