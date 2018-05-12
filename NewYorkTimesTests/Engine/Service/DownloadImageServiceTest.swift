//
//  DownloadImageServiceTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class DownloadImageServiceTest: XCTestCase {
    
    var sut: DownloadImageService!
    var session: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        session = URLSessionMock()
        sut = DownloadImageService(session: session)
    }
    
    func testDownloadSuccess() {
        //Given:
        let image = UIImage(named: "test1", in: Bundle(for: type(of: self)), compatibleWith: nil)!
        let data = UIImagePNGRepresentation(image)
        
        let expectation = XCTestExpectation(description: #function)
        
        //When:
        sut.download(url: URL(string: "https://static01.nyt.com/images/2018/05/12/us/12familyseparation/12familyseparation-thumbStandard.jpg")!) { (response) in
            switch response {
            case .success(let image):
                XCTAssertNotNil(image)
            case .failure(let error):
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        
        //Then:
        session.completion?(data, nil, nil)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testDownloadFailureCannotParseDataToImage() {
        //Given:
        let image = UIImage()
        let data = UIImagePNGRepresentation(image)
        
        let expectation = XCTestExpectation(description: #function)
        
        //When:
        sut.download(url: URL(string: "https://static01.nyt.com/images/2018/05/12/us/12familyseparation/12familyseparation-thumbStandard.jpg")!) { (response) in
            switch response {
            case .success(let image):
                XCTAssertNil(image)
            case .failure(let error):
                XCTAssertEqual(error as NSError, APIError.unexpected.error)
            }
            expectation.fulfill()
        }
        
        //Then:
        session.completion?(data, nil, nil)
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testDownloadFailure() {
        //Given:
        let expectation = XCTestExpectation(description: #function)
        
        //When:
        sut.download(url: URL(string: "https://static01.nyt.com/images/2018/05/12/us/12familyseparation/12familyseparation-thumbStandard.jpg")!) { (response) in
            switch response {
            case .success(let image):
                XCTAssertNil(image)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }

        //Then:
        session.completion?(nil, nil, nil)
        wait(for: [expectation], timeout: 0.1)
    }
}
