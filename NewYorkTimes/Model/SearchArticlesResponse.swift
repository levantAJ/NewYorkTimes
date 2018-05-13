//
//  SearchArticlesResponse.swift
//  NewYorkTimes
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

struct SearchArticlesResponse {
    var status: ResponseStatus = .unknown
    var articles: [Article]?
}

// MARK: - Mappable

extension SearchArticlesResponse: Mappable {
    mutating func mapping(map: Mapping) {
        status = map["status"] ?? .unknown
        articles = map["response.docs"]
    }
}
