//
//  Article.swift
//  NewYorkTimes
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

struct Article {
    var id: String?
    var snippet: String?
    var title: String?
    var webURL: URL?
}

// MARK: - Mappable

extension Article: Mappable {
    mutating func mapping(map: Mapping) {
        snippet = map["snippet"]
        title = map["headline.main"]
        webURL = map["web_url"]
        id = map["_id"]
    }
}
