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
        let map = Mapping(json: json)
        var object = T()
        object.mapping(map: map)
        return object
    }
}
