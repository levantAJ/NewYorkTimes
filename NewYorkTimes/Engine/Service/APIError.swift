//
//  APIError.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

enum APIError: Int {
    case unexpected = -1
    case mapping = -2
    case serverError = -3
    
    var code: Int {
        return rawValue
    }
    
    var description: String {
        switch self {
        case .unexpected:
            return NSLocalizedString("Unexpected error", comment: "")
        case .mapping:
            return NSLocalizedString("Cannot mapping object", comment: "")
        case .serverError:
            return NSLocalizedString("Cannot connect to server", comment: "")
        }
    }
    
    var error: NSError {
        return NSError(domain: "com.levantAJ.NewYorkTimes.error", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
