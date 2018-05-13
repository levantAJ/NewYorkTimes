//
//  SearchArticlesResultsViewControllerTest.swift
//  NewYorkTimesUITests
//
//  Created by levantAJ on 14/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest

class SearchArticlesResultsViewControllerTest: XCTestCase {
        
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testSearch() {
        let searchBar = app.searchFields["Search Articles"]
        searchBar.tap()
        searchBar.typeText("Hello world")
        app.keyboards.buttons["Search"].tap()
        
        sleep(10)
        
        app.collectionViews.cells.firstMatch.swipeUp()
        app.collectionViews.cells.firstMatch.swipeDown()
        
        app.buttons["Cancel"].tap()
        searchBar.tap()
        
        app.collectionViews.cells.firstMatch.swipeUp()
        app.collectionViews.cells.firstMatch.swipeDown()
    }
    
}
