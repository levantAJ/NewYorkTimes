//
//  MappableObjectAMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

@testable import NewYorkTimes

struct MappableObjectAMock: Mappable {
    var string: String?
    
    mutating func mapping(map: Mapping) {
        string = map["string"]
    }
}
