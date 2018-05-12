//
//  ArticleAggregateTableViewCellTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ArticleAggregateTableViewCellTest: XCTestCase {
    
    var sut: ArticleAggregateTableViewCell!
    var viewModel: ArticleAggregateTableViewCellViewModelMock!
    
    override func setUp() {
        super.setUp()
        viewModel = ArticleAggregateTableViewCellViewModelMock()
        let bundel = Bundle(for: ArticleAggregateTableViewCell.self)
        sut = bundel.loadNibNamed("ArticleAggregateTableViewCell", owner: nil)!.first as! ArticleAggregateTableViewCell
    }
    
    func testSetViewModel() {
        //When:
        sut.set(viewModel: viewModel)
        
        //Then:
        XCTAssertEqual(sut.bylineLabel.text, viewModel.byline)
        XCTAssertEqual(sut.dateLabel.text, viewModel.date)
        XCTAssertEqual(sut.sourceLabel.text, viewModel.source)
    }
    
}
