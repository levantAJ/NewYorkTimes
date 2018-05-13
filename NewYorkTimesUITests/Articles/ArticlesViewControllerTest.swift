//
//  ArticlesViewControllerTest.swift
//  NewYorkTimesUITests
//
//  Created by levantAJ on 14/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest

class ArticlesViewControllerTest: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testGoToArticleDetail() {
        sleep(5) //Waiting for network
        app.collectionViews.children(matching: .cell).element(boundBy: 0).tap()
        app.tables.cells.firstMatch.swipeLeft()
        app.tables.cells.firstMatch.swipeLeft()
        app.tables.cells.firstMatch.swipeRight()
    }
}
