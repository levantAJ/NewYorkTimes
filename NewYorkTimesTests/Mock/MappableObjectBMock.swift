//
//  MappableObjectBMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

@testable import NewYorkTimes

struct MappableObjectBMock: Mappable {
    var object: MappableObjectAMock?
    var array: [MappableObjectAMock]?
    
    mutating func mapping(map: Mapping) {
        object = map["object"]
        array = map["array"]
    }
}
