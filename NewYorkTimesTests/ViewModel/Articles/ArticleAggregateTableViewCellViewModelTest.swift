//
//  ArticleAggregateTableViewCellViewModelTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ArticleAggregateTableViewCellViewModelTest: XCTestCase {
    
    var sut: ArticleAggregateTableViewCellViewModel!
    
    func testDateNotEmpty() {
        //Given:
        let content = mockedContent()
        sut = ArticleAggregateTableViewCellViewModel(content: content)
        
        //When:
        let date = sut.date
        
        //Then:
        XCTAssertFalse(date.isEmpty)
    }
    
    func testDateIsEmpty() {
        //Given:
        var content = mockedContent()
        content.date = nil
        sut = ArticleAggregateTableViewCellViewModel(content: content)
        
        //When:
        let date = sut.date
        
        //Then:
        XCTAssertTrue(date.isEmpty)
    }
    
    func testBylineNotEmpty() {
        //Given:
        let content = mockedContent()
        sut = ArticleAggregateTableViewCellViewModel(content: content)
        
        //When:
        let byline = sut.byline
        
        //Then:
        XCTAssertFalse(byline.isEmpty)
    }
    
    func testBylineIsEmpty() {
        //Given:
        var content = mockedContent()
        content.byline = nil
        sut = ArticleAggregateTableViewCellViewModel(content: content)
        
        //When:
        let byline = sut.byline
        
        //Then:
        XCTAssertTrue(byline.isEmpty)
    }
    
    func testSourceNotEmpty() {
        //Given:
        let content = mockedContent()
        sut = ArticleAggregateTableViewCellViewModel(content: content)
        
        //When:
        let source = sut.source
        
        //Then:
        XCTAssertFalse(source.isEmpty)
    }
    
    func testSourceIsEmpty() {
        //Given:
        var content = mockedContent()
        content.source = nil
        sut = ArticleAggregateTableViewCellViewModel(content: content)
        
        //When:
        let source = sut.source
        
        //Then:
        XCTAssertTrue(source.isEmpty)
    }
}

// MARK: - Privates

extension ArticleAggregateTableViewCellViewModelTest {
    fileprivate func mockedContent() -> Content {
        return Content(title: "title", abstract: "abstract", url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html")!, thumbnailImageURL: URL(string: "https://static01.nyt.com/images/2018/05/12/arts/12perich1/12perich1-thumbStandard.jpg")!, date: Date(), multimedias: [
            Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
            ], byline: "byline", source: "source")
    }
}
