//
//  UITableViewMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

final class UITableViewMock: UITableView {
    var dequeueCell: UITableViewCell!
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueCell
    }
}
