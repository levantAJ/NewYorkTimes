//
//  SearchArticlesResultsCollectionViewCellViewModelTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class SearchArticlesResultsCollectionViewCellViewModelTest: XCTestCase {
    var sut: SearchArticlesResultsCollectionViewCellViewModel!
}

// MARK: - Test title getter

extension SearchArticlesResultsCollectionViewCellViewModelTest {
    
    func testTitleIsNotEmpty() {
        //Given:
        let expectedTitle = "expectedTitle"
        let article = Article(snippet: "snippet", title: expectedTitle, webURL: URL(string: "https://www.nytimes.com/1990/10/19/business/textron-posts-gain-in-profits.html"))
        sut = SearchArticlesResultsCollectionViewCellViewModel(article: article)
        
        //When:
        let title = sut.title
        
        //Then:
        XCTAssertEqual(title, expectedTitle)
    }
    
    func testTitleIsEmpty() {
        //Given:
        let expectedTitle: String? = nil
        let article = Article(snippet: "snippet", title: expectedTitle, webURL: URL(string: "https://www.nytimes.com/1990/10/19/business/textron-posts-gain-in-profits.html"))
        sut = SearchArticlesResultsCollectionViewCellViewModel(article: article)
        
        //When:
        let title = sut.title
        
        //Then:
        XCTAssertTrue(title.isEmpty)
    }
}

// MARK: - Test snippet getter

extension SearchArticlesResultsCollectionViewCellViewModelTest {
    
    func testSnippetIsNotEmpty() {
        //Given:
        let expectedSnippet = "expectedSnippet"
        let article = Article(snippet: expectedSnippet, title: "title", webURL: URL(string: "https://www.nytimes.com/1990/10/19/business/textron-posts-gain-in-profits.html"))
        sut = SearchArticlesResultsCollectionViewCellViewModel(article: article)
        
        //When:
        let snippet = sut.snippet
        
        //Then:
        XCTAssertEqual(snippet, expectedSnippet)
    }
    
    func testSnippetIsEmpty() {
        //Given:
        let expectedSnippet: String? = nil
        let article = Article(snippet: expectedSnippet, title: "title", webURL: URL(string: "https://www.nytimes.com/1990/10/19/business/textron-posts-gain-in-profits.html"))
        sut = SearchArticlesResultsCollectionViewCellViewModel(article: article)
        
        //When:
        let snippet = sut.snippet
        
        //Then:
        XCTAssertTrue(snippet.isEmpty)
    }
}
