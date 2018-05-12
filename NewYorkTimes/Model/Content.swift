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
    var thumbnailImageURL: URL?
    var date: Date?
    var multimedias: [Multimedia]?
}

// MARK: - Mappable

extension Content: Mappable {
    mutating func mapping(map: Mapping) {
        title = map["title"]
        abstract = map["abstract"]
        url = map["url"]
        thumbnailImageURL = map["thumbnail_standard"]
        date = map["published_date", .iso8601CombinedDateAndTime]
        multimedias = map["multimedia"]
    }
}

// MARK: - Equatable

extension Content: Equatable {
    static func == (lhs: Content, rhs: Content) -> Bool {
        return lhs.title == rhs.title
        && lhs.abstract == rhs.abstract
        && lhs.url == rhs.url
        && lhs.thumbnailImageURL == rhs.thumbnailImageURL
        && lhs.date == rhs.date
        && lhs.multimedias == rhs.multimedias
    }
}
