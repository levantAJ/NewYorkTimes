//
//  ArticleTitleTableViewCellTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ArticleTitleTableViewCellTest: XCTestCase {
    
    var sut: ArticleTitleTableViewCell!
    var viewModel: ArticleTitleTableViewCellViewModelMock!
    
    override func setUp() {
        super.setUp()
        viewModel = ArticleTitleTableViewCellViewModelMock()
        let bundle = Bundle(for: ArticleTitleTableViewCell.self)
        sut = bundle.loadNibNamed("ArticleTitleTableViewCell", owner: nil)!.first as! ArticleTitleTableViewCell
    }
    
    func testSetViewModel() {
        //When:
        sut.set(viewModel: viewModel)
        
        //Then:
        XCTAssertEqual(sut.titleLabel.text, viewModel.title)
    }
}
