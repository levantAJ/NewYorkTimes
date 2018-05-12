//
//  Multimedia.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

enum MultimediaFormat: String {
    case standardThumbnail = "Standard Thumbnail"
    case normal = "Normal"
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case unknown = "unknown"
}

enum MultimediaType: String {
    case image = "image"
    case unknown = "unknown"
}

struct Multimedia {
    var url: URL?
    var format: MultimediaFormat = .unknown
    var type: MultimediaType = .unknown
    var caption: String?
}

// MARK: - Mappable

extension Multimedia: Mappable {
    mutating func mapping(map: Mapping) {
        url = map["url"]
        format = map["format"] ?? .unknown
        type = map["type"] ?? .unknown
        caption = map["caption"]
    }
}

// MARK: - Equatable

extension Multimedia: Equatable {
    static func == (lhs: Multimedia, rhs: Multimedia) -> Bool {
        return lhs.format == rhs.format
            && lhs.url == rhs.url
            && lhs.type == rhs.type
            && lhs.caption == rhs.caption
    }
}
