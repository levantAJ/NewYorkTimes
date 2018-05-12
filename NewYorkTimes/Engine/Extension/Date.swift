//
//  Date.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

extension Date {
    var dateString: String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = DateFormat.date.format
        return dateFormater.string(from: self)
    }
}
