//
//  SearchArticlesResultsCollectionViewCellTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class SearchArticlesResultsCollectionViewCellTest: XCTestCase {
    
    var sut: SearchArticlesResultsCollectionViewCell!
    var viewModel: SearchArticlesResultsCollectionViewCellViewModelMock!
    
    override func setUp() {
        super.setUp()
        viewModel = SearchArticlesResultsCollectionViewCellViewModelMock()
        let bundle = Bundle(for: SearchArticlesResultsCollectionViewCell.self)
        sut = bundle.loadNibNamed("SearchArticlesResultsCollectionViewCell", owner: nil)!.first as! SearchArticlesResultsCollectionViewCell
    }
    
    func testSetViewModel() {
        //When:
        sut.set(viewModel: viewModel)
        
        //Then:
        XCTAssertEqual(sut.titleLabel.text, viewModel.title)
        XCTAssertEqual(sut.snippetLabel.text, viewModel.snippet)
    }
}
