//
//  ContentCollectionViewCellViewModelTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ContentCollectionViewCellViewModelTest: XCTestCase {
    
    var sut: ContentCollectionViewCellViewModel!
    var content: Content!
    var downloadImageService: DownloadImageServiceMock!
    
    override func setUp() {
        super.setUp()
        downloadImageService = DownloadImageServiceMock()
        content = mockedContent()
        sut = ContentCollectionViewCellViewModel(content: content, downloadImageService: downloadImageService)
    }
    
    func testIdIsNotEmpty() {
        //When:
        let expectedValue = sut.id
        
        //Then:
        XCTAssertFalse(expectedValue.isEmpty)
    }
    
    func testIdIsEmpty() {
        //Given:
        content.url = nil
        sut = ContentCollectionViewCellViewModel(content: content, downloadImageService: downloadImageService)
        
        //When:
        let expectedValue = sut.id
        
        //Then:
        XCTAssertTrue(expectedValue.isEmpty)
    }
    
    func testTitleIsNotEmpty() {
        //When:
        let expectedValue = sut.title
        
        //Then:
        XCTAssertFalse(expectedValue.isEmpty)
    }
    
    func testTitleIsEmpty() {
        //Given:
        content.title = nil
        sut = ContentCollectionViewCellViewModel(content: content, downloadImageService: downloadImageService)
        
        //When:
        let expectedValue = sut.title
        
        //Then:
        XCTAssertTrue(expectedValue.isEmpty)
    }
    
    func testDateIsNotEmpty() {
        //When:
        let expectedValue = sut.date
        
        //Then:
        XCTAssertFalse(expectedValue.isEmpty)
    }
    
    func testDateIsEmpty() {
        //Given:
        content.date = nil
        sut = ContentCollectionViewCellViewModel(content: content, downloadImageService: downloadImageService)
        
        //When:
        let expectedValue = sut.date
        
        //Then:
        XCTAssertTrue(expectedValue.isEmpty)
    }
    
    func testSnippetIsNotEmpty() {
        //When:
        let expectedValue = sut.snippet
        
        //Then:
        XCTAssertFalse(expectedValue.isEmpty)
    }
    
    func testSnippetIsEmpty() {
        //Given:
        content.abstract = nil
        sut = ContentCollectionViewCellViewModel(content: content, downloadImageService: downloadImageService)
        
        //When:
        let expectedValue = sut.snippet
        
        //Then:
        XCTAssertTrue(expectedValue.isEmpty)
    }
    
    func testLoadImageSuccess() {
        //Given:
        let expectation = self.expectation(description: #function)
        let expectedImage = UIImage()
        
        //When:
        sut.loadImage { [weak self] (id, response) in
            XCTAssertEqual(id, self?.sut.id)
            switch response {
            case .success(let image):
                XCTAssertEqual(expectedImage, image)
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        downloadImageService.completion?(.success(expectedImage))
        
        //Then:
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testLoadImageFailure() {
        //Given:
        let expectation = self.expectation(description: #function)
        let expectedError = NSError(domain: "test-error", code: 0, userInfo: [:])
        
        //When:
        sut.loadImage { [weak self] (id, response) in
            XCTAssertEqual(id, self?.sut.id)
            switch response {
            case .success(let image):
                XCTAssertNil(image)
            case .failure(let error):
                XCTAssertEqual(error as NSError, expectedError)
            }
            expectation.fulfill()
        }
        downloadImageService.completion?(.failure(expectedError))
        
        //Then:
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testLoadImageNotCall() {
        //Given:
        content.thumbnailImageURL = nil
        content.multimedias = nil
        let expectation = self.expectation(description: #function)
        expectation.isInverted = true
        sut = ContentCollectionViewCellViewModel(content: content, downloadImageService: downloadImageService)
        let expectedError = NSError(domain: "test-error", code: 0, userInfo: [:])
        let expectedImage = UIImage()
        
        //When:
        sut.loadImage { (id, response) in
            expectation.fulfill()
        }
        downloadImageService.completion?(.success(expectedImage))
        downloadImageService.completion?(.failure(expectedError))
        
        //Then:
        wait(for: [expectation], timeout: 0.1)
    }
    
}

// MARK: - Privates

extension ContentCollectionViewCellViewModelTest {
    fileprivate func mockedContent() -> Content {
        return Content(title: "title", abstract: "abstract", url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html")!, thumbnailImageURL: URL(string: "https://static01.nyt.com/images/2018/05/12/arts/12perich1/12perich1-thumbStandard.jpg")!, date: Date(), multimedias: [
            Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
            ], byline: "byline", source: "source")
    }
}
