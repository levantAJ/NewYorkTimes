//
//  SearchArticlesKeywordResultsCollectionViewCellTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class SearchArticlesKeywordResultsCollectionViewCellTest: XCTestCase {
    
    var sut: SearchArticlesKeywordResultsCollectionViewCell!
    var viewModel: SearchArticlesKeywordResultsCollectionViewCellViewModelMock!
    
    override func setUp() {
        super.setUp()
        viewModel = SearchArticlesKeywordResultsCollectionViewCellViewModelMock()
        let bundle = Bundle(for: SearchArticlesKeywordResultsCollectionViewCell.self)
        sut = bundle.loadNibNamed("SearchArticlesKeywordResultsCollectionViewCell", owner: nil)!.first as! SearchArticlesKeywordResultsCollectionViewCell
    }
    
    func testSetViewModel() {
        //When:
        sut.set(viewModel: viewModel)
        
        //Then:
        XCTAssertEqual(sut.titleLabel.text, viewModel.title)
    }
    
}
