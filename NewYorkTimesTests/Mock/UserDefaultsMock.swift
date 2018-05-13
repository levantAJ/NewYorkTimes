//
//  UserDefaultsMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

@testable import NewYorkTimes

final class UserDefaultsMock {
    var array: [Any]?
}

// MARK: - UserDefaultsProtocol

extension UserDefaultsMock: UserDefaultsProtocol {
    func array(forKey defaultName: String) -> [Any]? {
        return array
    }
    
    func set(_ value: Any?, forKey defaultName: String) {
        array = value as? [Any]
    }
}
