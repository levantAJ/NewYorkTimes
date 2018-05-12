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
    
    fileprivate let contentSerivce: ContentServiceApiProtocol
    fileprivate var currentPageIndex: UInt
    fileprivate var downloadImageService: DownloadImageServiceProtocol
    fileprivate var contents: [ContentCollectionViewCellViewModel]
    fileprivate var isLoading: Bool = false
    
    init(contentSerivce: ContentServiceApiProtocol) {
        self.contentSerivce = contentSerivce
        self.currentPageIndex = 0
        self.contents = []
        self.downloadImageService = DownloadImageService(session: URLSession.shared)
    }
    
    var numberOfRows: Int {
        return contents.count
    }
    
    func content(at index: Int) -> ContentCollectionViewCellViewModel? {
        if index < contents.count {
            return contents[index]
        }
        return nil
    }
    
    func append(content: ContentCollectionViewCellViewModel) {
        contents.append(content)
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
                let cellViewModels = contents.map { ContentCollectionViewCellViewModel(content: $0, downloadImageService: strongSelf.downloadImageService) }
                if (strongSelf.currentPageIndex == Constant.API.DefaultPageIndex) {
                    strongSelf.contents = cellViewModels
                    DispatchQueue.main.async {
                        strongSelf.onReloadData?()
                    }
                } else if !cellViewModels.isEmpty {
                    DispatchQueue.main.async {
                        strongSelf.onMoreData?(cellViewModels)
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
