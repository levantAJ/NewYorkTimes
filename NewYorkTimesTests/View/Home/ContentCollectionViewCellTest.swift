//
//  ContentCollectionViewCellTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ContentCollectionViewCellTest: XCTestCase {
    
    var sut: ContentCollectionViewCell!
    var viewModel: ContentCollectionViewCellViewModelMock!
    
    override func setUp() {
        super.setUp()
        viewModel = ContentCollectionViewCellViewModelMock()
        let bundel = Bundle(for: ContentCollectionViewCell.self)
        sut = bundel.loadNibNamed("ContentCollectionViewCell", owner: nil)!.first as! ContentCollectionViewCell
    }
    
    func testSetViewModelLoadImageSuccess() {
        //Given:
        let expectedImage = UIImage()
        
        //When:
        sut.set(viewModel: viewModel)
        XCTAssertNil(sut.imageView.image)
        viewModel.completion?(viewModel.id, .success(expectedImage))
        
        //Then:
        XCTAssertEqual(sut.titleLabel.text, viewModel.title)
        XCTAssertEqual(sut.snippetLabel.text, viewModel.snippet)
        XCTAssertEqual(sut.dateLabel.text, viewModel.date)
        XCTAssertEqual(sut.imageView.image, expectedImage)
    }
    
    func testSetViewModelLoadImageSuccessButDifferentId() {
        //Given:
        let expectedImage = UIImage()
        
        //When:
        sut.set(viewModel: viewModel)
        XCTAssertNil(sut.imageView.image)
        viewModel.completion?("newId", .success(expectedImage))
        
        //Then:
        XCTAssertEqual(sut.titleLabel.text, viewModel.title)
        XCTAssertEqual(sut.snippetLabel.text, viewModel.snippet)
        XCTAssertEqual(sut.dateLabel.text, viewModel.date)
        XCTAssertNil(sut.imageView.image)
    }
    
    func testSetViewModelLoadImageFailure() {
        //Given:
        let expectedError = NSError(domain: "test-error", code: 0, userInfo: [:])
        
        //When:
        sut.set(viewModel: viewModel)
        XCTAssertNil(sut.imageView.image)
        viewModel.completion?(viewModel.id, .failure(expectedError))
        
        //Then:
        XCTAssertEqual(sut.titleLabel.text, viewModel.title)
        XCTAssertEqual(sut.snippetLabel.text, viewModel.snippet)
        XCTAssertEqual(sut.dateLabel.text, viewModel.date)
        XCTAssertNil(sut.imageView.image)
    }
}
