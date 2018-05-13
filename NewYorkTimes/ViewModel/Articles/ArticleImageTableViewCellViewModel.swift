//
//  ArticleImageTableViewCellViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit

final class ArticleImageTableViewCellViewModel {
    let multimedia: Multimedia
    fileprivate let downloadImageService: DownloadImageServiceProtocol
    
    init(multimedia: Multimedia, downloadImageService: DownloadImageServiceProtocol) {
        self.multimedia = multimedia
        self.downloadImageService = downloadImageService
    }
}

// MARK: - ArticleImageTableViewCellProtocol

extension ArticleImageTableViewCellViewModel: ArticleImageTableViewCellProtocol {
    var caption: String {
        var components: [String] = []
        if let caption = multimedia.caption,
            !caption.isEmpty {
            components.append(caption)
        }
        if let copyright = multimedia.copyright,
            !copyright.isEmpty {
            components.append(copyright)
        }
        return components.joined(separator: " | ")
    }
    
    var id: String {
        return multimedia.url?.absoluteString ?? ""
    }
    
    func loadImage(completion: @escaping (String, Response<(UIImage)>) -> Void) {
        guard let imageURL = multimedia.url else { return }
        downloadImageService.download(url: imageURL) { [weak self] (response) in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                switch response {
                case .success(let image):
                    completion(strongSelf.id, .success(image))
                case .failure(let error):
                    completion(strongSelf.id, .failure(error))
                }
            }
        }
    }
}
