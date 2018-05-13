//
//  SearchArticlesResultsViewModelTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class SearchArticlesResultsViewModelTest: XCTestCase {
    
    var sut: SearchArticlesResultsViewModel!
    var searchArticlesService: SearchArticlesServiceApiMock!
    var searchArticlesKeywordDatabase: SearchArticlesKeywordDatabaseApiMock!

    override func setUp() {
        super.setUp()
        searchArticlesService = SearchArticlesServiceApiMock()
        searchArticlesKeywordDatabase = SearchArticlesKeywordDatabaseApiMock()
        sut = SearchArticlesResultsViewModel(searchArticlesService: searchArticlesService, searchArticlesKeywordDatabase: searchArticlesKeywordDatabase)
    }
}

// MARK: - Test refresh method

extension SearchArticlesResultsViewModelTest {
    func testRefreshSuccess() {
        //Given:
        let article = mockedArticle
        let contents = [article, article, article]
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        sut.onReloadData = { [weak self] in
            XCTAssertEqual(self?.sut.articleViewModels.count, contents.count)
            if let articleViewModels = self?.sut.articleViewModels {
                for viewModel in articleViewModels {
                    XCTAssertTrue(viewModel is SearchArticlesResultsCollectionViewCellViewModel)
                }
            }
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        erroredExpectation.isInverted = true
        sut.onError = { _ in
            erroredExpectation.fulfill()
        }
        
        let onLoadingExpectation = XCTestExpectation(description: #function + "onLoading")
        sut.onLoading = { showLoadingView in
            XCTAssertFalse(showLoadingView)
            onLoadingExpectation.fulfill()
        }
        
        //When:
        sut.refresh()
        XCTAssertTrue(sut.isLoading)
        searchArticlesService.completion?(.success(contents))
        
        //Then:
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(searchArticlesService.pageIndex, 0)
        XCTAssertEqual(searchArticlesService.query, sut.searchKeyword)
        wait(for: [reloadDataExpectation, erroredExpectation, onLoadingExpectation], timeout: 0.1)
    }
    
    func testRefreshNoResult() {
        //Given:
        let contents: [Article] = []
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        reloadDataExpectation.isInverted = true
        sut.onReloadData = {
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        sut.onError = { errorMessage in
            XCTAssertEqual(errorMessage, NSLocalizedString("No Results", comment: ""))
            erroredExpectation.fulfill()
        }
        
        let onLoadingExpectation = XCTestExpectation(description: #function + "onLoading")
        sut.onLoading = { showLoadingView in
            XCTAssertFalse(showLoadingView)
            onLoadingExpectation.fulfill()
        }
        
        //When:
        sut.refresh()
        XCTAssertTrue(sut.isLoading)
        searchArticlesService.completion?(.success(contents))
        
        //Then:
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(searchArticlesService.pageIndex, 0)
        XCTAssertEqual(searchArticlesService.query, sut.searchKeyword)
        wait(for: [reloadDataExpectation, erroredExpectation, onLoadingExpectation], timeout: 0.1)
    }
    
    func testRefreshFailure() {
        //Given:
        let expectedErrorMessage = "This is error message"
        let error = NSError(domain: "test-error", code: 0, userInfo: [NSLocalizedDescriptionKey: expectedErrorMessage])
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        reloadDataExpectation.isInverted = true
        sut.onReloadData = {
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        sut.onError = { errorMessage in
            XCTAssertEqual(errorMessage, expectedErrorMessage)
            erroredExpectation.fulfill()
        }
        
        let onLoadingExpectation = XCTestExpectation(description: #function + "onLoading")
        sut.onLoading = { showLoadingView in
            XCTAssertFalse(showLoadingView)
            onLoadingExpectation.fulfill()
        }
        
        //When:
        sut.refresh()
        XCTAssertTrue(sut.isLoading)
        searchArticlesService.completion?(.failure(error))
        
        //Then:
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(searchArticlesService.pageIndex, 0)
        XCTAssertEqual(searchArticlesService.query, sut.searchKeyword)
        wait(for: [reloadDataExpectation, erroredExpectation, onLoadingExpectation], timeout: 0.1)
    }
}

// MARK: - Test loadMore method

extension SearchArticlesResultsViewModelTest {
    func testLoadMoreSuccess() {
        //Given:
        let article = mockedArticle
        let contents = [article, article, article]
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        sut.onReloadData = { [weak self] in
            XCTAssertEqual(self?.sut.articleViewModels.count, contents.count)
            if let articleViewModels = self?.sut.articleViewModels {
                for viewModel in articleViewModels {
                    XCTAssertTrue(viewModel is SearchArticlesResultsCollectionViewCellViewModel)
                }
            }
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        erroredExpectation.isInverted = true
        sut.onError = { _ in
            erroredExpectation.fulfill()
        }
        
        let onLoadingExpectation = XCTestExpectation(description: #function + "onLoading")
        sut.onLoading = { showLoadingView in
            XCTAssertFalse(showLoadingView)
            onLoadingExpectation.fulfill()
        }
        
        //When:
        sut.loadMore()
        XCTAssertTrue(sut.isLoading)
        searchArticlesService.completion?(.success(contents))
        
        //Then:
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(searchArticlesService.pageIndex, 1)
        XCTAssertEqual(searchArticlesService.query, sut.searchKeyword)
        wait(for: [reloadDataExpectation, erroredExpectation, onLoadingExpectation], timeout: 0.1)
    }
    
    func testLoadMoreNoResult() {
        //Given:
        let contents: [Article] = []
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        reloadDataExpectation.isInverted = true
        sut.onReloadData = {
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        sut.onError = { errorMessage in
            XCTAssertEqual(errorMessage, NSLocalizedString("No Results", comment: ""))
            erroredExpectation.fulfill()
        }
        
        let onLoadingExpectation = XCTestExpectation(description: #function + "onLoading")
        sut.onLoading = { showLoadingView in
            XCTAssertFalse(showLoadingView)
            onLoadingExpectation.fulfill()
        }
        
        //When:
        sut.loadMore()
        XCTAssertTrue(sut.isLoading)
        searchArticlesService.completion?(.success(contents))
        
        //Then:
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(searchArticlesService.pageIndex, 1)
        XCTAssertEqual(searchArticlesService.query, sut.searchKeyword)
        wait(for: [reloadDataExpectation, erroredExpectation, onLoadingExpectation], timeout: 0.1)
    }
    
    func testLoadMoreFailure() {
        //Given:
        let expectedErrorMessage = "This is error message"
        let error = NSError(domain: "test-error", code: 0, userInfo: [NSLocalizedDescriptionKey: expectedErrorMessage])
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        reloadDataExpectation.isInverted = true
        sut.onReloadData = {
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        sut.onError = { errorMessage in
            XCTAssertEqual(errorMessage, expectedErrorMessage)
            erroredExpectation.fulfill()
        }
        
        let onLoadingExpectation = XCTestExpectation(description: #function + "onLoading")
        sut.onLoading = { showLoadingView in
            XCTAssertFalse(showLoadingView)
            onLoadingExpectation.fulfill()
        }
        
        //When:
        sut.loadMore()
        XCTAssertTrue(sut.isLoading)
        searchArticlesService.completion?(.failure(error))
        
        //Then:
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(searchArticlesService.pageIndex, 1)
        XCTAssertEqual(searchArticlesService.query, sut.searchKeyword)
        wait(for: [reloadDataExpectation, erroredExpectation, onLoadingExpectation], timeout: 0.1)
    }
}

// MARK: - Test search method

extension SearchArticlesResultsViewModelTest {
    func testSearchSuccess() {
        //Given:
        let searchKeyword = "searchKeyword"
        let article = mockedArticle
        let contents = [article, article, article]
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        reloadDataExpectation.expectedFulfillmentCount = 2
        var onReloadDataCount = 0
        sut.onReloadData = { [weak self] in
            if onReloadDataCount == 0 {
                XCTAssertEqual(self?.sut.articleViewModels.count, 0)
                onReloadDataCount = onReloadDataCount + 1
            } else {
                XCTAssertEqual(self?.sut.articleViewModels.count, contents.count)
                if let articleViewModels = self?.sut.articleViewModels {
                    for viewModel in articleViewModels {
                        XCTAssertTrue(viewModel is SearchArticlesResultsCollectionViewCellViewModel)
                    }
                }
            }
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        erroredExpectation.isInverted = true
        sut.onError = { _ in
            erroredExpectation.fulfill()
        }
        
        let onLoadingExpectation = XCTestExpectation(description: #function + "onLoading")
        onLoadingExpectation.expectedFulfillmentCount = 2
        var onLoadingCount = 0
        sut.onLoading = { showLoadingView in
            if onLoadingCount == 0 {
                XCTAssertTrue(showLoadingView)
                onLoadingCount = onLoadingCount + 1
            } else {
                XCTAssertFalse(showLoadingView)
            }
            onLoadingExpectation.fulfill()
        }
        
        //When:
        sut.search(keyword: searchKeyword)
        XCTAssertTrue(sut.isLoading)
        searchArticlesService.completion?(.success(contents))
        
        //Then:
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(searchArticlesService.pageIndex, 0)
        XCTAssertEqual(searchArticlesService.query, sut.searchKeyword)
        XCTAssertEqual(searchArticlesKeywordDatabase.keyword, searchKeyword)
        XCTAssertEqual(sut.searchKeyword, searchKeyword)
        wait(for: [reloadDataExpectation, erroredExpectation, onLoadingExpectation], timeout: 0.1)
    }
    
    func testSearchNoResult() {
        //Given:
        let searchKeyword = "searchKeyword"
        let contents: [Article] = []
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        reloadDataExpectation.expectedFulfillmentCount = 1
        sut.onReloadData = { [weak self] in
            XCTAssertEqual(self?.sut.articleViewModels.count, contents.count)
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        sut.onError = { errorMessage in
            XCTAssertEqual(errorMessage, NSLocalizedString("No Results", comment: ""))
            erroredExpectation.fulfill()
        }
        
        let onLoadingExpectation = XCTestExpectation(description: #function + "onLoading")
        onLoadingExpectation.expectedFulfillmentCount = 2
        var onLoadingCount = 0
        sut.onLoading = { showLoadingView in
            if onLoadingCount == 0 {
                XCTAssertTrue(showLoadingView)
                onLoadingCount = onLoadingCount + 1
            } else {
                XCTAssertFalse(showLoadingView)
            }
            onLoadingExpectation.fulfill()
        }
        
        //When:
        sut.search(keyword: searchKeyword)
        XCTAssertTrue(sut.isLoading)
        searchArticlesService.completion?(.success(contents))
        
        //Then:
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(searchArticlesService.pageIndex, 0)
        XCTAssertEqual(searchArticlesService.query, sut.searchKeyword)
        XCTAssertEqual(searchArticlesKeywordDatabase.keyword, searchKeyword)
        XCTAssertEqual(sut.searchKeyword, searchKeyword)
        wait(for: [reloadDataExpectation, erroredExpectation, onLoadingExpectation], timeout: 0.1)
    }
    
    func testSearchError() {
        //Given:
        let searchKeyword = "searchKeyword"
        let expectedErrorMessage = "This is error message"
        let error = NSError(domain: "test-error", code: 0, userInfo: [NSLocalizedDescriptionKey: expectedErrorMessage])
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        reloadDataExpectation.expectedFulfillmentCount = 1
        sut.onReloadData = { [weak self] in
            XCTAssertEqual(self?.sut.articleViewModels.count, 0)
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        sut.onError = { errorMessage in
            XCTAssertEqual(errorMessage, expectedErrorMessage)
            erroredExpectation.fulfill()
        }
        
        let onLoadingExpectation = XCTestExpectation(description: #function + "onLoading")
        onLoadingExpectation.expectedFulfillmentCount = 2
        var onLoadingCount = 0
        sut.onLoading = { showLoadingView in
            if onLoadingCount == 0 {
                XCTAssertTrue(showLoadingView)
                onLoadingCount = onLoadingCount + 1
            } else {
                XCTAssertFalse(showLoadingView)
            }
            onLoadingExpectation.fulfill()
        }
        
        //When:
        sut.search(keyword: searchKeyword)
        XCTAssertTrue(sut.isLoading)
        searchArticlesService.completion?(.failure(error))
        
        //Then:
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(searchArticlesService.pageIndex, 0)
        XCTAssertEqual(searchArticlesService.query, sut.searchKeyword)
        XCTAssertEqual(searchArticlesKeywordDatabase.keyword, searchKeyword)
        XCTAssertEqual(sut.searchKeyword, searchKeyword)
        wait(for: [reloadDataExpectation, erroredExpectation, onLoadingExpectation], timeout: 0.1)
    }
}

// MARK: - Test retrieveRecentlyKeywords method

extension SearchArticlesResultsViewModelTest {
    func testRetrieveRecentlyKeywordsSuccess() {
        //Given:
        let keywords = ["keyword1", "keyword2", "keyword3"]
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        sut.onReloadData = { [weak self] in
            XCTAssertEqual(self?.sut.articleViewModels.count, 3)
            if let articleViewModels = self?.sut.articleViewModels {
                for viewModel in articleViewModels {
                    XCTAssertTrue(viewModel is SearchArticlesKeywordResultsCollectionViewCellViewModel)
                }
            }
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        erroredExpectation.isInverted = true
        sut.onError = { _ in
            erroredExpectation.fulfill()
        }
        
        let onLoadingExpectation = XCTestExpectation(description: #function + "onLoading")
        onLoadingExpectation.isInverted = true
        sut.onLoading = { _ in
            onLoadingExpectation.fulfill()
        }
        
        //When:
        sut.retrieveRecentlyKeywords()
        searchArticlesKeywordDatabase.requestingCompletion?(.success(keywords))
        
        //Then:
        XCTAssertEqual(searchArticlesKeywordDatabase.pageIndex, 0)
        XCTAssertEqual(searchArticlesKeywordDatabase.pageSize, 10)
        wait(for: [reloadDataExpectation, erroredExpectation, onLoadingExpectation], timeout: 0.1)
    }
    
    func testRetrieveRecentlyKeywordsFailure() {
        //Given:
        let expectedErrorMessage = "This is error message"
        let error = NSError(domain: "test-error", code: 0, userInfo: [NSLocalizedDescriptionKey: expectedErrorMessage])
        let reloadDataExpectation = XCTestExpectation(description: #function + "onReloadData")
        reloadDataExpectation.isInverted = true
        sut.onReloadData = {
            reloadDataExpectation.fulfill()
        }
        
        let erroredExpectation = XCTestExpectation(description: #function + "onError")
        sut.onError = { errorMessage in
            XCTAssertEqual(errorMessage, expectedErrorMessage)
            erroredExpectation.fulfill()
        }
        
        let onLoadingExpectation = XCTestExpectation(description: #function + "onLoading")
        onLoadingExpectation.isInverted = true
        sut.onLoading = { _ in
            onLoadingExpectation.fulfill()
        }
        
        //When:
        sut.retrieveRecentlyKeywords()
        searchArticlesKeywordDatabase.requestingCompletion?(.failure(error))
        
        //Then:
        XCTAssertEqual(searchArticlesKeywordDatabase.pageIndex, 0)
        XCTAssertEqual(searchArticlesKeywordDatabase.pageSize, 10)
        wait(for: [reloadDataExpectation, erroredExpectation, onLoadingExpectation], timeout: 0.1)
    }
}

// MARK: - Test articleViewModel method

extension SearchArticlesResultsViewModelTest {
    func testArticleViewModelShouldReturnNilWhenIndexIsNagative() {
        //When:
        let viewModel = sut.articleViewModel(at: -1)
        
        //Then:
        XCTAssertNil(viewModel)
    }
    
    func testArticleViewModelShouldReturnNilWhenIndexIsMoreThanNoViewModel() {
        //When:
        let viewModel = sut.articleViewModel(at: 1000)
        
        //Then:
        XCTAssertNil(viewModel)
    }
}

extension SearchArticlesResultsViewModelTest {
    fileprivate var mockedArticle: Article {
        return Article(snippet: "snippet", title: "title", webURL: URL(string: "https://www.nytimes.com/1990/10/19/business/textron-posts-gain-in-profits.html"))
    }
}
