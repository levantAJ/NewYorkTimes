//
//  MultimediaTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class MultimediaTest: XCTestCase {
    
    var sut: Multimedia!
    
    override func setUp() {
        super.setUp()
        sut = Multimedia()
    }
    
    func testMapping() {
        //Given:
        let url = "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"
        let caption = "caption"
        let copyright = "copyright"
        let json = [
            "url": url,
            "type": "image",
            "format": "Standard Thumbnail",
            "caption": caption,
            "copyright": copyright,
        ]
        
        //When:
        let mapping = Mapping(json: json)
        sut.mapping(map: mapping)
        
        //Then:
        XCTAssertEqual(sut.url?.absoluteString, url)
        XCTAssertEqual(sut.type, .image)
        XCTAssertEqual(sut.format, .standardThumbnail)
        XCTAssertEqual(sut.caption, caption)
        XCTAssertEqual(sut.copyright, copyright)
    }
    
    func testMappingTypeShouldBeUnknown() {
        //Given:
        let url = "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"
        let caption = "caption"
        let copyright = "copyright"
        let json = [
            "url": url,
            "type": "something",
            "format": "Standard Thumbnail",
            "caption": caption,
            "copyright": copyright,
        ]
        
        //When:
        let mapping = Mapping(json: json)
        sut.mapping(map: mapping)
        
        //Then:
        XCTAssertEqual(sut.url?.absoluteString, url)
        XCTAssertEqual(sut.type, .unknown)
        XCTAssertEqual(sut.format, .standardThumbnail)
        XCTAssertEqual(sut.caption, caption)
        XCTAssertEqual(sut.copyright, copyright)
    }
    
    func testMappingFormatShouldBeUnknown() {
        //Given:
        let url = "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"
        let caption = "caption"
        let copyright = "copyright"
        let json = [
            "url": url,
            "type": "something",
            "format": "something",
            "caption": caption,
            "copyright": copyright,
        ]
        
        //When:
        let mapping = Mapping(json: json)
        sut.mapping(map: mapping)
        
        //Then:
        XCTAssertEqual(sut.url?.absoluteString, url)
        XCTAssertEqual(sut.type, .unknown)
        XCTAssertEqual(sut.format, .unknown)
        XCTAssertEqual(sut.caption, caption)
        XCTAssertEqual(sut.copyright, copyright)
    }
    
    func testEqualShouldReturnTrue() {
        sut = Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
        let multimedia = Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
        XCTAssertEqual(sut, multimedia)
    }
    
    func testEqualShouldReturnFalseWhenCaptionNotMatch() {
        sut = Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
        let multimedia = Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption1", copyright: "copyright")
        XCTAssertNotEqual(sut, multimedia)
    }
    
    func testEqualShouldReturnFalseWhenURLNotMatch() {
        sut = Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perichd.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
        let multimedia = Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
        XCTAssertNotEqual(sut, multimedia)
    }
    
    func testEqualShouldReturnFalseWhenFormatNotMatch() {
        sut = Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo440, type: .image, caption: "caption", copyright: "copyright")
        let multimedia = Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
        XCTAssertNotEqual(sut, multimedia)
    }
    
    func testEqualShouldReturnFalseWhenTypeNotMatch() {
        sut = Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .unknown, caption: "caption", copyright: "copyright")
        let multimedia = Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
        XCTAssertNotEqual(sut, multimedia)
    }
    
    func testEqualShouldReturnFalseWhenCopyrightNotMatch() {
        sut = Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright1")
        let multimedia = Multimedia(url: URL(string: "https://www.nytimes.com/2018/05/11/arts/music/12perich.html"), format: .mediumThreeByTwo210, type: .image, caption: "caption", copyright: "copyright")
        XCTAssertNotEqual(sut, multimedia)
    }
}
