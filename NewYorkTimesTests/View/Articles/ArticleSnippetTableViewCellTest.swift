//
//  ArticleSnippetTableViewCellTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ArticleSnippetTableViewCellTest: XCTestCase {
    
    var sut: ArticleSnippetTableViewCell!
    var viewModel: ArticleSnippetTableViewCellViewModelMock!
    
    override func setUp() {
        super.setUp()
        viewModel = ArticleSnippetTableViewCellViewModelMock()
        let bundel = Bundle(for: ArticleSnippetTableViewCell.self)
        sut = bundel.loadNibNamed("ArticleSnippetTableViewCell", owner: nil)!.first as! ArticleSnippetTableViewCell
    }
    
    func testSetViewModel() {
        //When:
        sut.set(viewModel: viewModel)
        
        //Then:
        XCTAssertEqual(sut.snippetLabel.text, viewModel.snippet)
    }
}
