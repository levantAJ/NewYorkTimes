//
//  DownloadImageServiceMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit
import Foundation
@testable import NewYorkTimes

final class DownloadImageServiceMock: DownloadImageServiceProtocol {
    var completion: ((Response<UIImage>) -> Void)?
    
    func download(url: URL, completion: @escaping (Response<UIImage>) -> Void) {
        self.completion = completion
    }
}
