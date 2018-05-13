//
//  UITableView.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(type: T.Type, bundle: Bundle? = nil) {
        let identifier = String(describing: type)
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: type)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
}
