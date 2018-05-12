//
//  ArticleImageTableViewCellViewModelTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class ArticleImageTableViewCellViewModelTest: XCTestCase {
    
    var sut: ArticleImageTableViewCellViewModel!
    var downloadImageService: DownloadImageServiceMock!
    
    override func setUp() {
        super.setUp()
        downloadImageService = DownloadImageServiceMock()
    }
    
    func testCaptionHasCaptionAndCopyright() {
        //Given:
        let multimedia = mockedMutilmedia()
        sut = ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: downloadImageService)
        
        //When:
        let caption = sut.caption
        
        //Then:
        XCTAssertEqual(caption, "\(multimedia.caption!) | \(multimedia.copyright!)")
    }
    
    func testCaptionHasCaptionAndCopyrightIsNil() {
        //Given:
        var multimedia = mockedMutilmedia()
        multimedia.copyright = nil
        sut = ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: downloadImageService)
        
        //When:
        let caption = sut.caption
        
        //Then:
        XCTAssertEqual(caption, multimedia.caption!)
    }
    
    func testCaptionHasCaptionAndCopyrightIsEmpty() {
        //Given:
        var multimedia = mockedMutilmedia()
        multimedia.copyright = ""
        sut = ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: downloadImageService)
        
        //When:
        let caption = sut.caption
        
        //Then:
        XCTAssertEqual(caption, multimedia.caption!)
    }
    
    func testCaptionCaptionIsNilAndCopyright() {
        //Given:
        var multimedia = mockedMutilmedia()
        multimedia.caption = nil
        sut = ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: downloadImageService)
        
        //When:
        let caption = sut.caption
        
        //Then:
        XCTAssertEqual(caption, multimedia.copyright!)
    }
    
    func testCaptionCaptionIsEmptyAndCopyright() {
        //Given:
        var multimedia = mockedMutilmedia()
        multimedia.caption = ""
        sut = ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: downloadImageService)
        
        //When:
        let caption = sut.caption
        
        //Then:
        XCTAssertEqual(caption, multimedia.copyright!)
    }
    
    func testCaptionCaptionIsEmptyAndCopyrightIsEmpty() {
        //Given:
        var multimedia = mockedMutilmedia()
        multimedia.caption = ""
        multimedia.copyright = ""
        sut = ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: downloadImageService)
        
        //When:
        let caption = sut.caption
        
        //Then:
        XCTAssertTrue(caption.isEmpty)
    }
    
    func testCaptionCaptionIsEmptyAndCopyrightIsNil() {
        //Given:
        var multimedia = mockedMutilmedia()
        multimedia.caption = ""
        multimedia.copyright = nil
        sut = ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: downloadImageService)
        
        //When:
        let caption = sut.caption
        
        //Then:
        XCTAssertTrue(caption.isEmpty)
    }
    
    func testCaptionCaptionIsNilAndCopyrightIsEmpty() {
        //Given:
        var multimedia = mockedMutilmedia()
        multimedia.caption = nil
        multimedia.copyright = ""
        sut = ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: downloadImageService)
        
        //When:
        let caption = sut.caption
        
        //Then:
        XCTAssertTrue(caption.isEmpty)
    }
    
    func testCaptionCaptionIsNilAndCopyrightIsNil() {
        //Given:
        var multimedia = mockedMutilmedia()
        multimedia.caption = nil
        multimedia.copyright = nil
        sut = ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: downloadImageService)
        
        //When:
        let caption = sut.caption
        
        //Then:
        XCTAssertTrue(caption.isEmpty)
    }
    
    func testIdIsNotEmpty() {
        //Given:
        let multimedia = mockedMutilmedia()
        sut = ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: downloadImageService)
        
        //When:
        let id = sut.id
        
        //Then:
        XCTAssertEqual(id, "https://www.nytimes.com/2018/05/11/arts/music/12perich.html")
    }
    
    func testIdIsEmpty() {
        //Given:
        var multimedia = mockedMutilmedia()
        multimedia.url = nil
        sut = ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: downloadImageService)
        
        //When:
        let id = sut.id
        
        //Then:
        XCTAssertTrue(id.isEmpty)
    }
    
    func testLoadImageSuccess() {
        //Given:
        let multimedia = mockedMutilmedia()
        let expectation = self.expectation(description: #function)
        sut = ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: downloadImageService)
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
        let multimedia = mockedMutilmedia()
        let expectation = self.expectation(description: #function)
        sut = ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: downloadImageService)
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
        var multimedia = mockedMutilmedia()
        multimedia.url = nil
        let expectation = self.expectation(description: #function)
        expectation.isInverted = true
        sut = ArticleImageTableViewCellViewModel(multimedia: multimedia, downloadImageService: downloadImageService)
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

extension ArticleImageTableViewCellViewModelTest {
    fileprivate func mockedMutilmedia() -> Multimedia {
        return Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
    }
}
