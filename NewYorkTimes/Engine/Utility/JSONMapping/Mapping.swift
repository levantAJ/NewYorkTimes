//
//  Mapping.swift
//  NewYorkTimes
//
//  Created by levantAJ on 11/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

struct Mapping {
    fileprivate var json: [String: Any]
    
    init(json: [String: Any]) {
        self.json = json
    }
    
    //Convert object to string
    subscript(key: String) -> String? {
        return json[key] as? String
    }
    
    //Convert object to URL
    subscript(key: String) -> URL? {
        guard let string = json[key] as? String else { return nil }
        return URL(string: string)
    }
    
    //Convert object to Date
    subscript(key: String, dateFormat: DateFormat) -> Date? {
        guard let string = json[key] as? String else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.format
        return formatter.date(from: string)
    }
}
