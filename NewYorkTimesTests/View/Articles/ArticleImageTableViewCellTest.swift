//
//  ArticleImageTableViewCellTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ArticleImageTableViewCellTest: XCTestCase {
    
    var sut: ArticleImageTableViewCell!
    var viewModel: ArticleImageTableViewCellViewModelMock!
    
    override func setUp() {
        super.setUp()
        viewModel = ArticleImageTableViewCellViewModelMock()
        let bundle = Bundle(for: ArticleImageTableViewCell.self)
        sut = bundle.loadNibNamed("ArticleImageTableViewCell", owner: nil)!.first as! ArticleImageTableViewCell
    }
    
    func testSetViewModelLoadImageSuccess() {
        //Given:
        let expectedImage = UIImage()
        
        //When:
        sut.set(viewModel: viewModel)
        XCTAssertNil(sut.multimediaImageView.image)
        viewModel.completion?(viewModel.id, .success(expectedImage))
        
        //Then:
        XCTAssertEqual(sut.captionLabel.text, viewModel.caption)
        XCTAssertEqual(sut.multimediaImageView.image, expectedImage)
    }
    
    func testSetViewModelLoadImageSuccessButDifferentId() {
        //Given:
        let expectedImage = UIImage()
        
        //When:
        sut.set(viewModel: viewModel)
        XCTAssertNil(sut.multimediaImageView.image)
        viewModel.completion?("newId", .success(expectedImage))
        
        //Then:
        XCTAssertEqual(sut.captionLabel.text, viewModel.caption)
        XCTAssertNil(sut.multimediaImageView.image)
    }
    
    func testSetViewModelLoadImageFailure() {
        //Given:
        let expectedError = NSError(domain: "test-error", code: 0, userInfo: [:])
        
        //When:
        sut.set(viewModel: viewModel)
        XCTAssertNil(sut.multimediaImageView.image)
        viewModel.completion?(viewModel.id, .failure(expectedError))
        
        //Then:
        XCTAssertEqual(sut.captionLabel.text, viewModel.caption)
        XCTAssertNil(sut.multimediaImageView.image)
    }
}
