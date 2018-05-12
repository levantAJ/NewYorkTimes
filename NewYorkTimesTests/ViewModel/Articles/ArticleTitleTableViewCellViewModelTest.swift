//
//  ArticleTitleTableViewCellViewModelTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ArticleTitleTableViewCellViewModelTest: XCTestCase {
    
    var sut: ArticleTitleTableViewCellViewModel!
    
    func testTitleNotEmpty() {
        //Given:
        let content = mockedContent()
        sut = ArticleTitleTableViewCellViewModel(content: content)
        
        //When:
        let title = sut.title
        
        //Then:
        XCTAssertFalse(title.isEmpty)
    }
    
    func testTitleIsEmpty() {
        //Given:
        var content = mockedContent()
        content.title = nil
        sut = ArticleTitleTableViewCellViewModel(content: content)
        
        //When:
        let title = sut.title
        
        //Then:
        XCTAssertTrue(title.isEmpty)
    }
}

// MARK: - Privates

extension ArticleTitleTableViewCellViewModelTest {
    fileprivate func mockedContent() -> Content {
        return Content(title: "title", abstract: "abstract", url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html")!, thumbnailImageURL: URL(string: "https://static01.nyt.com/images/2018/05/12/arts/12perich1/12perich1-thumbStandard.jpg")!, date: Date(), multimedias: [
            Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
            ], byline: "byline", source: "source")
    }
}
