//
//  DownloadImageService.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation
import UIKit

protocol DownloadImageServiceProtocol {
    func download(url: URL, completion: @escaping (Response<UIImage>) -> Void)
}

struct DownloadImageService {
    fileprivate let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
}

// MARK: - DownloadImageServiceProtocol

extension DownloadImageService: DownloadImageServiceProtocol {
    func download(url: URL, completion: @escaping (Response<UIImage>) -> Void) {
        let request = URLRequest(url: url)
        session.dataTask(with: request) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(.success(image))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(APIError.unexpected.error))
            }
        }.resume()
    }
}
