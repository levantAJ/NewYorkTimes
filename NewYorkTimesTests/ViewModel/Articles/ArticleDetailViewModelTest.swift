//
//  ArticleDetailViewModelTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ArticleDetailViewModelTest: XCTestCase {
    
    var sut: ArticleDetailViewModel!
    var content: Content!
    var index: Int!
    
    override func setUp() {
        super.setUp()
        content = mockedContent()
        index = 0
        sut = ArticleDetailViewModel(content: content, index: index)
    }
    
    func testInitWithMultimedia() {
        XCTAssertEqual(sut.index, index)
        XCTAssertEqual(sut.content, content)
        XCTAssertEqual(sut.itemViewModels.count, 4)
        if sut.itemViewModels.count == 4 {
            XCTAssertTrue(sut.itemViewModels[0] is ArticleTitleTableViewCellViewModel)
            XCTAssertTrue(sut.itemViewModels[1] is ArticleAggregateTableViewCellViewModel)
            XCTAssertTrue(sut.itemViewModels[2] is ArticleSnippetTableViewCellViewModel)
            XCTAssertTrue(sut.itemViewModels[3] is ArticleImageTableViewCellViewModel)
        }
    }
    
    func testInitWithoutMultimedia() {
        //Given:
        content.multimedias = nil
        
        //When:
        sut = ArticleDetailViewModel(content: content, index: index)
        
        //Then:
        XCTAssertEqual(sut.index, index)
        XCTAssertEqual(sut.content, content)
        XCTAssertEqual(sut.itemViewModels.count, 3)
        if sut.itemViewModels.count == 4 {
            XCTAssertTrue(sut.itemViewModels[0] is ArticleTitleTableViewCellViewModel)
            XCTAssertTrue(sut.itemViewModels[1] is ArticleAggregateTableViewCellViewModel)
            XCTAssertTrue(sut.itemViewModels[2] is ArticleSnippetTableViewCellViewModel)
        }
    }
    
    func testItemViewModelIsArticleTitleTableViewCellViewModel() {
        //When:
        let viewModel = sut.itemViewModel(at: 0)
        
        //Then:
        XCTAssertTrue(viewModel is ArticleTitleTableViewCellViewModel)
    }
    
    func testItemViewModelIsArticleAggregateTableViewCellViewModel() {
        //When:
        let viewModel = sut.itemViewModel(at: 1)
        
        //Then:
        XCTAssertTrue(viewModel is ArticleAggregateTableViewCellViewModel)
    }
    
    func testItemViewModelIsArticleSnippetTableViewCellViewModel() {
        //When:
        let viewModel = sut.itemViewModel(at: 2)
        
        //Then:
        XCTAssertTrue(viewModel is ArticleSnippetTableViewCellViewModel)
    }
    
    func testItemViewModelIsArticleImageTableViewCellViewModel() {
        //When:
        let viewModel = sut.itemViewModel(at: 3)
        
        //Then:
        XCTAssertTrue(viewModel is ArticleImageTableViewCellViewModel)
    }
    
    func testItemViewModelIsNil() {
        //When:
        let viewModel = sut.itemViewModel(at: 4)
        
        //Then:
        XCTAssertNil(viewModel)
    }
}

// MARK: - Privates

extension ArticleDetailViewModelTest {
    fileprivate func mockedContent() -> Content {
        return Content(title: "title", abstract: "abstract", url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html")!, thumbnailImageURL: URL(string: "https://static01.nyt.com/images/2018/05/12/arts/12perich1/12perich1-thumbStandard.jpg")!, date: Date(), multimedias: [
            Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
            ], byline: "byline", source: "source")
    }
}
