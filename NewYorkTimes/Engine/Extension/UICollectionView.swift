//
//  UICollectionView.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(type: T.Type) {
        let identifier = String(describing: type)
        let nib = UINib(nibName: identifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: type)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}
