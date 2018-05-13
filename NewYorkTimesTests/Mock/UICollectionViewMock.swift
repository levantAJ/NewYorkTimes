//
//  UICollectionViewMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

final class UICollectionViewMock: UICollectionView {
    var cell: UICollectionViewCell!
    
    override func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
        return cell
    }
}
