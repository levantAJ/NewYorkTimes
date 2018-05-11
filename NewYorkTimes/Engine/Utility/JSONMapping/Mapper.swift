//
//  Mapper.swift
//  NewYorkTimes
//
//  Created by levantAJ on 11/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

struct Mapper<T: Mappable> {
    func map(json: Any) -> T? {
        guard let json = json as? [String: Any] else { return nil }
        let mapping = Mapping(json: json)
        var object = T()
        object.mapping(map: mapping)
        return object
    }
    
    func map(json: Any) -> [T]? {
        guard let jsonArray = json as? [Any] else { return nil }
        var objects: [T] = []
        for jsonObject in jsonArray {
            guard let jsonObject = jsonObject as? [String: Any] else { continue }
            let mapping = Mapping(json: jsonObject)
            var object = T()
            object.mapping(map: mapping)
            objects.append(object)
        }
        return objects
    }
}
