//
//  DateTest.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import XCTest
@testable import NewYorkTimes

class DateTest: XCTestCase {
    var sut: Date!
    
    func testDateString() {
        //Given:
        var component = DateComponents()
        component.year = 2018
        component.month = 5
        component.day = 12
        sut = Calendar.current.date(from: component)
        
        //When:
        let dateString = sut.dateString
        
        //Then:
        XCTAssertEqual(dateString, "12/05/2018")
    }
}
