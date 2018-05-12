//
//  ArticlesViewModelTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ArticlesViewModelTest: XCTestCase {
    
    var sut: ArticlesViewModel!
    var contents: [Content]!
    var currentIndex: Int!
    
    override func setUp() {
        super.setUp()
        contents = [mockedContent(), mockedContent(), mockedContent()]
        currentIndex = 2
        sut = ArticlesViewModel(contents: contents, currentIndex: currentIndex)
    }
    
    func testInit() {
        XCTAssertEqual(sut.currentIndex, currentIndex)
        XCTAssertEqual(sut.detailViewModels.count, contents.count)
        for (index, content) in contents.enumerated() {
            XCTAssertEqual(sut.detailViewModels[index].index, index)
            XCTAssertEqual(sut.detailViewModels[index].content, content)
        }
    }
    
    func testInitWithContentsIsEmpty() {
        //Given:
        contents = []
        
        //When:
        sut = ArticlesViewModel(contents: contents, currentIndex: 0)
        
        //Then
        XCTAssertEqual(sut.currentIndex, 0)
        XCTAssertTrue(sut.detailViewModels.isEmpty)
    }
    
    func testDetailViewModelIsNilWhenIndexIsLessThanZero() {
        //When:
        let viewModel = sut.detailViewModel(at: -1)
        
        //Then:
        XCTAssertNil(viewModel)
    }
    
    func testDetailViewModelIsNilWhenIndexIsGreatThanNumberOfViewModels() {
        //When:
        let viewModel = sut.detailViewModel(at: contents.count)
        
        //Then:
        XCTAssertNil(viewModel)
    }
    
    func testDetailViewModelShouldNotBeNil() {
        for (index, content) in contents.enumerated() {
            let viewModel = sut.detailViewModel(at: index)
            XCTAssertEqual(viewModel?.content, content)
        }
    }
}

// MARK: - Privates

extension ArticlesViewModelTest {
    fileprivate func mockedContent() -> Content {
        return Content(title: "title", abstract: "abstract", url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html")!, thumbnailImageURL: URL(string: "https://static01.nyt.com/images/2018/05/12/arts/12perich1/12perich1-thumbStandard.jpg")!, date: Date(), multimedias: [
            Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
            ], byline: "byline", source: "source")
    }
}

