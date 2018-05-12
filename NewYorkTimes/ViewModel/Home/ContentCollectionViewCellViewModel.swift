//
//  ContentCollectionViewCellViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import UIKit
import Foundation

final class ContentCollectionViewCellViewModel {
    fileprivate let content: Content
    fileprivate let downloadImageService: DownloadImageServiceProtocol
    fileprivate var image: UIImage?
    
    init(content: Content, downloadImageService: DownloadImageServiceProtocol) {
        self.content = content
        self.downloadImageService = downloadImageService
    }
}

// MARK: - ContentCollectionViewCellProtocol

extension ContentCollectionViewCellViewModel: ContentCollectionViewCellProtocol {
    var id: String {
        return content.url?.absoluteString ?? ""
    }
    
    var title: String {
        return content.title ?? ""
    }
    
    var date: String {
        return content.date?.dateString ?? ""
    }
    
    var snippet: String {
        return content.abstract ?? ""
    }
    
    func loadImage(completion: @escaping (String, Response<(UIImage)>) -> Void) {
        let url = content.multimedias?.last?.url ?? content.thumbnailImageURL
        guard let imageURL = url else { return }
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
