//
//  ImageLoadable.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

protocol ImageLoadable {
    var id: String { get }
    func loadImage(completion: @escaping (String, Response<(UIImage)>) -> Void)
}
