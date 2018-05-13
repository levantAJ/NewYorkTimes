//
//  HomeViewControllerTest.swift
//  NewYorkTimesUITests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest

class HomeViewControllerTest: XCTestCase {
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testListOfContents() {
        let searchBar = app.searchFields["Search Articles"]
        XCTAssertTrue(searchBar.exists)
        
        sleep(5) //Waiting for network
        let cell = app.collectionViews.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(cell.exists)
    
        let image = cell.children(matching: .other).element.children(matching: .other).element
        image.swipeUp()
    }
}
