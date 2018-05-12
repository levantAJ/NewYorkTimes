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
    var onMoreData: (() -> Void)?
    
    fileprivate let contentSerivce: ContentServiceApiProtocol
    fileprivate var currentPageIndex: UInt
    fileprivate var contents: [ContentCollectionViewCellViewModel]
    
    init(contentSerivce: ContentServiceApiProtocol) {
        self.contentSerivce = contentSerivce
        self.currentPageIndex = 0
        self.contents = []
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
        self.currentPageIndex = pageIndex
        self.contentSerivce.request(pageIndex: 0, pageSize: Constant.API.PageSize) { [weak self] response in
            guard let strongSelf = self else { return }
            switch response {
            case .success(let contents):
                if (strongSelf.currentPageIndex == Constant.API.DefaultPageIndex) {
                    strongSelf.contents = contents.map { ContentCollectionViewCellViewModel(content: $0) }
                    DispatchQueue.main.async {
                        strongSelf.onReloadData?()
                    }
                } else {
                    DispatchQueue.main.async {
                        strongSelf.onMoreData?()
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
