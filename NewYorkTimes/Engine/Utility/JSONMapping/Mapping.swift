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
    
    //Convert object to a string
    subscript(key: String) -> String? {
        return json[key] as? String
    }

    //Convert object to an URL
    subscript(key: String) -> URL? {
        guard let string = json[key] as? String else { return nil }
        return URL(string: string)
    }
    
    //Convert object to a date
    subscript(key: String, dateFormat: DateFormat) -> Date? {
        guard let string = json[key] as? String else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.format
        return formatter.date(from: string)
    }
    
    //Convert object to a mappable object
    subscript<T: Mappable>(key: String) -> T? {
        guard let value = json[key] else { return nil }
        return Mapper<T>().map(json: value)
    }
    
    //Convert object to an array of mappable objects
    subscript<T: Mappable>(key: String) -> [T]? {
        guard let value = json[key] else { return nil }
        return Mapper<T>().map(json: value)
    }
}
