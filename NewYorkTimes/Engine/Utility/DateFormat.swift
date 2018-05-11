//
//  DateFormat.swift
//  NewYorkTimes
//
//  Created by levantAJ on 11/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

enum DateFormat {
    case iso8601Date
    case iso8601CombinedDateAndTime
    case custom(format: String)
    
    var format: String {
        switch self {
        case .iso8601Date:
            return "yyyy-MM-dd"
        case .iso8601CombinedDateAndTime:
            return "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        case .custom(let format):
            return format
        }
    }
}
