//
//  Article.swift
//  NewYorkTimes
//
//  Created by levantAJ on 11/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

struct Content {
    var title: String?
    var abstract: String?
    var url: URL?
    var imageURL: URL?
    var date: Date?
}

//MARK: - Mappable

extension Content: Mappable {
    mutating func mapping(map: Mapping) {
        title = map["title"]
        abstract = map["abstract"]
        url = map["url"]
        imageURL = map["thumbnail_standard"]
        date = map["published_date", .iso8601CombinedDateAndTime]
    }
}
