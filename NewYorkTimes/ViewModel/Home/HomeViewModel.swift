//
//  HomeViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

final class HomeViewModel {
    var onError: ((String) -> Void)?
    var onReloadData: (() -> Void)?
    var onMoreData: (([ContentCollectionViewCellViewModel]) -> Void)?
    
    fileprivate(set) var contentViewModels: [ContentCollectionViewCellViewModel]
    fileprivate(set) var isLoading: Bool
    fileprivate let contentSerivce: ContentServiceApiProtocol
    fileprivate var currentPageIndex: UInt
    fileprivate var downloadImageService: DownloadImageServiceProtocol
    
    init(contentSerivce: ContentServiceApiProtocol) {
        self.contentSerivce = contentSerivce
        self.currentPageIndex = 0
        self.contentViewModels = []
        self.downloadImageService = DownloadImageService(session: URLSession.shared)
        self.isLoading = false
    }
    
    func contentViewModel(at index: Int) -> ContentCollectionViewCellViewModel? {
        if index < contentViewModels.count && index >= 0 {
            return contentViewModels[index]
        }
        return nil
    }
    
    func append(contentViewModel: ContentCollectionViewCellViewModel) {
        contentViewModels.append(contentViewModel)
    }
}

// MARK : - Pageable

extension HomeViewModel: Pageable {
    func refresh() {
        request(pageIndex: 0)
    }
    
    func loadMore() {
        request(pageIndex: currentPageIndex + 1)
    }
}

// MARK : - Privates

extension HomeViewModel {
    fileprivate func request(pageIndex: UInt) {
        guard !isLoading else { return } //Avoid making multiple requests a the same time.
        isLoading = true
        currentPageIndex = pageIndex
        contentSerivce.request(pageIndex: currentPageIndex, pageSize: Constant.API.PageSize) { [weak self] response in
            guard let strongSelf = self else { return }
            strongSelf.isLoading = false
            switch response {
            case .success(let contents):
                let contentViewModels = contents.map { ContentCollectionViewCellViewModel(content: $0, downloadImageService: strongSelf.downloadImageService) }
                if (strongSelf.currentPageIndex == Constant.API.DefaultPageIndex) {
                    strongSelf.contentViewModels = contentViewModels
                    DispatchQueue.main.async {
                        strongSelf.onReloadData?()
                    }
                } else if !contentViewModels.isEmpty {
                    DispatchQueue.main.async {
                        strongSelf.onMoreData?(contentViewModels)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    strongSelf.onError?(error.localizedDescription)
                }
            }
        }
    }
}
