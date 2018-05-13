//
//  ArticleDetailViewControllerTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ArticleDetailViewControllerTest: XCTestCase {
    
    var viewModel: ArticleDetailViewModelMock!
    var sut: ArticleDetailViewController!
    
    override func setUp() {
        super.setUp()
        viewModel = ArticleDetailViewModelMock()
        sut = UIStoryboard.viewController(screenName: "ArticleDetailViewController", storyboardName: "Articles") as! ArticleDetailViewController
        sut.viewModel = viewModel
    }
    
    func testTableViewNumberOfRowsInSection() {
        //Given:
        let itemViewModels = [ArticleTitleTableViewCellViewModelMock(), ArticleTitleTableViewCellViewModelMock(), ArticleTitleTableViewCellViewModelMock()]
        viewModel.itemViewModels = itemViewModels
        
        //When:
        let numberOfRowsInSection = sut.tableView(UITableView(), numberOfRowsInSection: 0)
        
        //Then:
        XCTAssertEqual(numberOfRowsInSection, itemViewModels.count)
    }
    
    func testTableViewCellForRowAtIndexPathForArticleTitleTableViewCell() {
        //Given:
        let tableView = mockedTableView
        let bundle = Bundle(for: ArticleTitleTableViewCell.self)
        let expectedCell = bundle.loadNibNamed("ArticleTitleTableViewCell", owner: nil)!.first as! ArticleTitleTableViewCell
        tableView.dequeueCell = expectedCell
        viewModel.itemViewModelAtIndex = ArticleTitleTableViewCellViewModelMock()
        
        //When:
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        //Then:
        XCTAssertEqual(cell, expectedCell)
    }
    
    func testTableViewCellForRowAtIndexPathForArticleAggregateTableViewCell() {
        //Given:
        let tableView = mockedTableView
        let bundle = Bundle(for: ArticleAggregateTableViewCell.self)
        let expectedCell = bundle.loadNibNamed("ArticleAggregateTableViewCell", owner: nil)!.first as! ArticleAggregateTableViewCell
        tableView.dequeueCell = expectedCell
        viewModel.itemViewModelAtIndex = ArticleAggregateTableViewCellViewModelMock()
        
        //When:
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        //Then:
        XCTAssertEqual(cell, expectedCell)
    }
    
    func testTableViewCellForRowAtIndexPathForArticleSnippetTableViewCell() {
        //Given:
        let tableView = mockedTableView
        let bundle = Bundle(for: ArticleSnippetTableViewCell.self)
        let expectedCell = bundle.loadNibNamed("ArticleSnippetTableViewCell", owner: nil)!.first as! ArticleSnippetTableViewCell
        tableView.dequeueCell = expectedCell
        viewModel.itemViewModelAtIndex = ArticleSnippetTableViewCellViewModelMock()
        
        //When:
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        //Then:
        XCTAssertEqual(cell, expectedCell)
    }
    
    func testTableViewCellForRowAtIndexPathForArticleImageTableViewCell() {
        //Given:
        let tableView = mockedTableView
        let bundle = Bundle(for: ArticleImageTableViewCell.self)
        let expectedCell = bundle.loadNibNamed("ArticleImageTableViewCell", owner: nil)!.first as! ArticleImageTableViewCell
        tableView.dequeueCell = expectedCell
        viewModel.itemViewModelAtIndex = ArticleImageTableViewCellViewModelMock()
        
        //When:
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        //Then:
        XCTAssertEqual(cell, expectedCell)
    }
}

// MARK: - Privates

extension ArticleDetailViewControllerTest {
    fileprivate var mockedTableView: UITableViewMock {
        let tableView = UITableViewMock()
        let bundle = Bundle(for: ArticleDetailViewControllerTest.self)
        tableView.register(type: ArticleTitleTableViewCell.self, bundle: bundle)
        tableView.register(type: ArticleAggregateTableViewCell.self, bundle: bundle)
        tableView.register(type: ArticleSnippetTableViewCell.self, bundle: bundle)
        tableView.register(type: ArticleImageTableViewCell.self, bundle: bundle)
        return tableView
    }
}
