//
//  HomeViewControllerTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 14/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class HomeViewControllerTest: XCTestCase {
    
    var viewModel: HomeViewModelMock!
    var sut: HomeViewController!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModelMock()
        sut = UIStoryboard.viewController(screenName: "HomeViewController", storyboardName: "Home") as! HomeViewController
        sut.viewModel = viewModel
        sut.loadViewIfNeeded()
    }
    
    func testCollectionViewNumberOfItemsInSection() {
        //Given:
        let collectionVeiw = mockedCollectionView
        let contentViewModels = [ContentCollectionViewCellViewModelMock(), ContentCollectionViewCellViewModelMock(), ContentCollectionViewCellViewModelMock()]
        viewModel.contentViewModels = contentViewModels
        
        //When:
        let numberOfItemsInSection = sut.collectionView(collectionVeiw, numberOfItemsInSection: 0)
        
        //Then:
        XCTAssertEqual(numberOfItemsInSection, contentViewModels.count)
    }
    
    func testCollectionViewCellForItemAtIndexPath() {
        //Given:
        let collectionView = mockedCollectionView
        let bundle = Bundle(for: ContentCollectionViewCell.self)
        let expectedCell = bundle.loadNibNamed("ContentCollectionViewCell", owner: nil)!.first as! ContentCollectionViewCell
        collectionView.cell = expectedCell
        
        //When:
        let cell = sut.collectionView(collectionView, cellForItemAt: IndexPath(item: 0, section: 0))
        
        //Then:
        XCTAssertEqual(cell, expectedCell)
    }
    
    func testScrollViewDidScrollShouldLoadMoreContentOffsetYMoreThanContentSizeHeight() {
        //Given:
        let scrollView = UIScrollView()
        scrollView.contentOffset.y = 100
        scrollView.contentSize.height = 0
        scrollView.frame.size.height = 0
        
        //When:
        sut.scrollViewDidScroll(scrollView)
        
        //Then:
        XCTAssertTrue(viewModel.didLoadMore)
    }
    
    func testScrollViewDidScrollShouldLoadMoreContentOffsetYEqualContentSizeHeight() {
        //Given:
        let scrollView = UIScrollView()
        scrollView.contentOffset.y = 100
        scrollView.contentSize.height = 100
        scrollView.frame.size.height = 0
        
        //When:
        sut.scrollViewDidScroll(scrollView)
        
        //Then:
        XCTAssertTrue(viewModel.didLoadMore)
    }
    
    func testScrollViewDidScrollShouldNotLoadMore() {
        //Given:
        let scrollView = UIScrollView()
        scrollView.contentOffset.y = 100
        scrollView.contentSize.height = 200
        scrollView.frame.size.height = 0
        
        //When:
        sut.scrollViewDidScroll(scrollView)
        
        //Then:
        XCTAssertFalse(viewModel.didLoadMore)
    }
    
    func testRefreshControlValueChanged() {
        //When:
        sut.refreshControlValueChanged()
        
        //Then:
        XCTAssertTrue(viewModel.didRefresh)
    }
}

// MARK: - Privates

extension HomeViewControllerTest {
    fileprivate var mockedCollectionView: UICollectionViewMock {
        let layout = UICollectionViewLayout()
        return UICollectionViewMock(frame: .zero, collectionViewLayout: layout)
    }
}
