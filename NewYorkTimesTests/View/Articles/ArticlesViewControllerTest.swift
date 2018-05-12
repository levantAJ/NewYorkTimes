//
//  ArticlesViewControllerTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ArticlesViewControllerTest: XCTestCase {
    
    var sut: ArticlesViewController!
    var detailVC: ArticleDetailViewController!
    var detailViewModel: ArticleDetailViewModel!
    var content: Content!
    var viewModel: ArticlesViewModelMock!
    
    override func setUp() {
        super.setUp()
        content = mockedContent()
        detailViewModel = ArticleDetailViewModel(content: content, index: 0)
        detailVC = ArticleDetailViewController()
        detailVC.viewModel = detailViewModel
        sut = UIStoryboard.viewController(screenName: "ArticlesViewController", storyboardName: "Articles") as! ArticlesViewController
        viewModel = ArticlesViewModelMock()
        sut.viewModel = viewModel
        sut.loadViewIfNeeded()
    }
    
    func testPageViewControllerViewControllerBeforeWithDetailViewModelIsNil() {
        //Given:
        let pageVC = UIPageViewController()
        detailVC.viewModel = nil
        
        //When:
        let expectedVC = sut.pageViewController(pageVC, viewControllerBefore: detailVC)
        
        //Then:
        XCTAssertNil(expectedVC)
    }
    
    func testPageViewControllerViewControllerBeforeWithDetailViewModelIsNotNilAndCurrentIndexLessThanZero() {
        //Given:
        let pageVC = UIPageViewController()
        detailViewModel = ArticleDetailViewModel(content: content, index: -1)
        detailVC.viewModel = detailViewModel
        
        //When:
        let expectedVC = sut.pageViewController(pageVC, viewControllerBefore: detailVC)
        
        //Then:
        XCTAssertNil(expectedVC)
    }
    
    func testPageViewControllerViewControllerBeforeWithDetailViewModelIsNotNilAndCurrentIndexGreaterThanZeroDetailViewModelIsNil() {
        //Given:
        let pageVC = UIPageViewController()
        detailViewModel = ArticleDetailViewModel(content: content, index: 1)
        detailVC.viewModel = detailViewModel
        viewModel.detailViewModelAtIndex = nil
        
        //When:
        let expectedVC = sut.pageViewController(pageVC, viewControllerBefore: detailVC)
        
        //Then:
        XCTAssertNil(expectedVC)
    }
    
    func testPageViewControllerViewControllerBeforeWithDetailViewModelIsNotNilAndCurrentIndexGreaterThanZeroDetailViewModelIsNoNil() {
        //Given:
        let pageVC = UIPageViewController()
        detailViewModel = ArticleDetailViewModel(content: content, index: 1)
        detailVC.viewModel = detailViewModel
        viewModel.detailViewModelAtIndex = detailViewModel
        
        //When:
        let expectedVC = sut.pageViewController(pageVC, viewControllerBefore: detailVC)
        
        //Then:
        XCTAssertNotNil(expectedVC)
        XCTAssertNotEqual(expectedVC, detailVC)
        XCTAssertTrue(expectedVC is ArticleDetailViewController)
        if let expectedVC = expectedVC as? ArticleDetailViewController {
            XCTAssertEqual(expectedVC.viewModel.content, detailViewModel.content)
            XCTAssertEqual(expectedVC.viewModel.index, detailViewModel.index)
            XCTAssertEqual(expectedVC.viewModel.itemViewModels.count, detailViewModel.itemViewModels.count)
        }
    }

    func testPageViewControllerViewControllerAfterWithDetailViewModelIsNil() {
        //Given:
        let pageVC = UIPageViewController()
        detailVC.viewModel = nil
        
        //When:
        let expectedVC = sut.pageViewController(pageVC, viewControllerAfter: detailVC)
        
        //Then:
        XCTAssertNil(expectedVC)
    }
    
    func testPageViewControllerViewControllerAfterWithDetailViewModelIsNotNilAndCurrentIndexGreaterThanDetailViewModelsCount() {
        //Given:
        let pageVC = UIPageViewController()
        detailViewModel = ArticleDetailViewModel(content: content, index: 10)
        detailVC.viewModel = detailViewModel
        
        //When:
        let expectedVC = sut.pageViewController(pageVC, viewControllerAfter: detailVC)
        
        //Then:
        XCTAssertNil(expectedVC)
    }
    
    func testPageViewControllerViewControllerAfterWithDetailViewModelIsNotNilAndCurrentIndexLessThanDetailViewModelsCountAndDetailViewModelIsNil() {
        //Given:
        let pageVC = UIPageViewController()
        detailViewModel = ArticleDetailViewModel(content: content, index: 1)
        detailVC.viewModel = detailViewModel
        viewModel.detailViewModels = [detailViewModel, detailViewModel, detailViewModel]
        viewModel.detailViewModelAtIndex = nil
        
        //When:
        let expectedVC = sut.pageViewController(pageVC, viewControllerAfter: detailVC)
        
        //Then:
        XCTAssertNil(expectedVC)
    }
    
    func testPageViewControllerViewControllerBeforeWithDetailViewModelIsNotNilCurrentIndexGreaterThanZeroDetailViewModelIsNoNil() {
        //Given:
        let pageVC = UIPageViewController()
        detailViewModel = ArticleDetailViewModel(content: content, index: 1)
        detailVC.viewModel = detailViewModel
        viewModel.detailViewModels = [detailViewModel, detailViewModel, detailViewModel]
        viewModel.detailViewModelAtIndex = detailViewModel
        
        //When:
        let expectedVC = sut.pageViewController(pageVC, viewControllerAfter: detailVC)
        
        //Then:
        XCTAssertNotNil(expectedVC)
        XCTAssertNotEqual(expectedVC, detailVC)
        XCTAssertTrue(expectedVC is ArticleDetailViewController)
        if let expectedVC = expectedVC as? ArticleDetailViewController {
            XCTAssertEqual(expectedVC.viewModel.content, detailViewModel.content)
            XCTAssertEqual(expectedVC.viewModel.index, detailViewModel.index)
            XCTAssertEqual(expectedVC.viewModel.itemViewModels.count, detailViewModel.itemViewModels.count)
        }
    }
}

// MARK: - Privates

extension ArticlesViewControllerTest {
    fileprivate func mockedContent() -> Content {
        return Content(title: "title", abstract: "abstract", url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html")!, thumbnailImageURL: URL(string: "https://static01.nyt.com/images/2018/05/12/arts/12perich1/12perich1-thumbStandard.jpg")!, date: Date(), multimedias: [
            Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
            ], byline: "byline", source: "source")
    }
}

