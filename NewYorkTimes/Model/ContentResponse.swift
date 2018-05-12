//
//  ContentResponse.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

struct ContentResponse {
    var status: ResponseStatus = .unknown
    var contents: [Content] = []
}

// MARK: - Mappable

extension ContentResponse: Mappable {
    mutating func mapping(map: Mapping) {
        status = map["status"] ?? .unknown
        contents = map["results"] ?? []
    }
}
