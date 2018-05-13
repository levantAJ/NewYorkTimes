//
//  SearchArticlesResultsViewControllerTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class SearchArticlesResultsViewControllerTest: XCTestCase {
    var sut: SearchArticlesResultsViewController!
    var viewModel: SearchArticlesResultsViewModelMock!
    
    override func setUp() {
        super.setUp()
        viewModel = SearchArticlesResultsViewModelMock()
        let bundle = Bundle(for: SearchArticlesResultsViewController.self)
        sut = UIStoryboard.viewController(screenName: "SearchArticlesResultsViewController", storyboardName: "SearchArticles", bundle: bundle) as! SearchArticlesResultsViewController
        sut.viewModel = viewModel
        sut.loadViewIfNeeded()
    }
    
    func testUpdateSearchResults() {
        //When:
        sut.updateSearchResults(for: UISearchController())
        
        //Then:
        XCTAssertFalse(sut.view.isHidden)
    }
    
    func testSearchBarCancelButtonClicked() {
        //When:
        sut.searchBarCancelButtonClicked(UISearchBar())
        
        //Then:
        XCTAssertTrue(sut.searchMessageLabel.isHidden)
    }
    
    func testSearchBarSearchButtonClicked() {
        //Given:
        let searchBar = UISearchBar()
        searchBar.text = "Search keyword"
        
        //When:
        sut.searchBarSearchButtonClicked(searchBar)
        
        //Then:
        XCTAssertEqual(searchBar.text, viewModel.searchKeyword)
    }
    
    func testSearchBarTextDidBeginEditing() {
        //When:
        sut.searchBarTextDidBeginEditing(UISearchBar())
        
        //Then:
        XCTAssertTrue(viewModel.didCallRetrieveRecentlyKeywords)
    }
    
    func testCollectionViewNumberOfItemsInSection() {
        //Given:
        viewModel.articleViewModels = [SearchArticlesResultsCollectionViewCellViewModelMock(), SearchArticlesResultsCollectionViewCellViewModelMock(), SearchArticlesResultsCollectionViewCellViewModelMock()]
        
        //When:
        let numberOfItemsInSection = sut.collectionView(mockedCollectionView, numberOfItemsInSection: 0)
       
        //Then:
        XCTAssertEqual(numberOfItemsInSection, viewModel.articleViewModels.count)
    }
    
    func testCollectionViewCellForItemAtWithSearchArticlesResultsCollectionViewCell() {
        //Given:
        let collectionView = mockedCollectionView
        let bundle = Bundle(for: SearchArticlesResultsCollectionViewCell.self)
        let expectedCell = bundle.loadNibNamed("SearchArticlesResultsCollectionViewCell", owner: nil)!.first as! SearchArticlesResultsCollectionViewCell
        collectionView.cell = expectedCell
        let indexPath = IndexPath(item: 0, section: 0)
        viewModel.articleViewModelAtIndex = SearchArticlesResultsCollectionViewCellViewModelMock()
        
        //When:
        let cell = sut.collectionView(collectionView, cellForItemAt: indexPath)
        
        //Then:
        XCTAssertEqual(cell, expectedCell)
    }
    
    func testCollectionViewCellForItemAtWithSearchArticlesKeywordResultsCollectionViewCell() {
        //Given:
        let collectionView = mockedCollectionView
        let bundle = Bundle(for: SearchArticlesKeywordResultsCollectionViewCell.self)
        let expectedCell = bundle.loadNibNamed("SearchArticlesKeywordResultsCollectionViewCell", owner: nil)!.first as! SearchArticlesKeywordResultsCollectionViewCell
        collectionView.cell = expectedCell
        let indexPath = IndexPath(item: 0, section: 0)
        viewModel.articleViewModelAtIndex = SearchArticlesKeywordResultsCollectionViewCellViewModelMock()
        
        //When:
        let cell = sut.collectionView(collectionView, cellForItemAt: indexPath)
        
        //Then:
        XCTAssertEqual(cell, expectedCell)
    }
    
    func testCollectionViewCollectionViewLayoutSizeForItemAtWhenArticleModelIsNil() {
        //Given:
        let width: CGFloat = 100.0
        sut.view.bounds = CGRect(x: 0, y: 0, width: width, height: 200)
        viewModel.articleViewModelAtIndex = nil
        
        //When:
        let size = sut.collectionView(mockedCollectionView, layout: UICollectionViewLayout(), sizeForItemAt: IndexPath(item: 0, section: 0))
        
        //Then:
        XCTAssertEqual(size.width, width)
        XCTAssertEqual(size.height, 44)
    }
    
    func testCollectionViewCollectionViewLayoutSizeForItemAtWhenArticleModelIsSearchArticlesKeywordResultsCollectionViewCellViewModel() {
        //Given:
        let width: CGFloat = 100.0
        sut.view.bounds = CGRect(x: 0, y: 0, width: width, height: 200)
        viewModel.articleViewModelAtIndex = SearchArticlesKeywordResultsCollectionViewCellViewModelMock()
        
        //When:
        let size = sut.collectionView(mockedCollectionView, layout: UICollectionViewLayout(), sizeForItemAt: IndexPath(item: 0, section: 0))
        
        //Then:
        XCTAssertEqual(size.width, width)
        XCTAssertEqual(size.height, 44)
    }
    
    func testCollectionViewCollectionViewLayoutSizeForItemAtWhenArticleModelIsSearchArticlesResultsCollectionViewCellViewModelHasCacheSize() {
        //Given:
        let expectedSize = CGSize(width: 100, height: 200)
        let articleViewModelAtIndex = SearchArticlesResultsCollectionViewCellViewModelMock()
        articleViewModelAtIndex.cachedSize = expectedSize
        viewModel.articleViewModelAtIndex = articleViewModelAtIndex
        
        //When:
        let size = sut.collectionView(mockedCollectionView, layout: UICollectionViewLayout(), sizeForItemAt: IndexPath(item: 0, section: 0))
        
        //Then:
        XCTAssertEqual(size, expectedSize)
    }

    func testCollectionViewCollectionViewLayoutSizeForItemAtWhenArticleModelIsSearchArticlesResultsCollectionViewCellViewModelHasNoCacheSize() {
        //Given:
        let articleViewModelAtIndex = SearchArticlesResultsCollectionViewCellViewModelMock()
        articleViewModelAtIndex.cachedSize = nil
        viewModel.articleViewModelAtIndex = articleViewModelAtIndex
        
        //When:
        let size = sut.collectionView(mockedCollectionView, layout: UICollectionViewLayout(), sizeForItemAt: IndexPath(item: 0, section: 0))
        
        //Then:
        XCTAssertEqual(articleViewModelAtIndex.cachedSize, size)
    }

}

// MARK: - Privates

extension SearchArticlesResultsViewControllerTest {
    fileprivate var mockedCollectionView: UICollectionViewMock {
        let layout = UICollectionViewLayout()
        return UICollectionViewMock(frame: .zero, collectionViewLayout: layout)
    }
}
