//
//  HomeViewModel.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol: Pageable {
    var onError: ((String) -> Void)?  { get set }
    var onReloadData: (() -> Void)?  { get set }
    var onMoreData: (([ContentCollectionViewCellProtocol]) -> Void)? { get set }
    var contentViewModels: [ContentCollectionViewCellProtocol] { get }
    func contentViewModel(at index: Int) -> ContentCollectionViewCellProtocol?
    func append(contentViewModel: ContentCollectionViewCellProtocol)
}

final class HomeViewModel {
    var onError: ((String) -> Void)?
    var onReloadData: (() -> Void)?
    var onMoreData: (([ContentCollectionViewCellProtocol]) -> Void)?
    fileprivate(set) var isLoading: Bool
    fileprivate(set) var currentPageIndex: UInt
    fileprivate(set) var contentViewModels: [ContentCollectionViewCellProtocol]
    fileprivate let contentSerivce: ContentServiceApiProtocol
    fileprivate var downloadImageService: DownloadImageServiceProtocol
    
    init(contentSerivce: ContentServiceApiProtocol) {
        self.contentSerivce = contentSerivce
        self.currentPageIndex = 0
        self.contentViewModels = []
        self.downloadImageService = DownloadImageService(session: URLSession.shared)
        self.isLoading = false
    }
}

// MARK: - HomeViewModel

extension HomeViewModel: HomeViewModelProtocol {
    func contentViewModel(at index: Int) -> ContentCollectionViewCellProtocol? {
        if index < contentViewModels.count && index >= 0 {
            return contentViewModels[index]
        }
        return nil
    }
    
    func append(contentViewModel: ContentCollectionViewCellProtocol) {
        contentViewModels.append(contentViewModel)
    }
}

// MARK: - Pageable

extension HomeViewModel: Pageable {
    func refresh() {
        retrieveContents(pageIndex: 0)
    }
    
    func loadMore() {
        retrieveContents(pageIndex: currentPageIndex + 1)
    }
}

// MARK: - Privates

extension HomeViewModel {
    fileprivate func retrieveContents(pageIndex: UInt) {
        guard !isLoading else { return } //Avoid making multiple requests a the same time.
        isLoading = true
        currentPageIndex = pageIndex
        contentSerivce.request(pageIndex: currentPageIndex, pageSize: Constant.API.PageSize) { [weak self] response in
            guard let strongSelf = self else { return }
            strongSelf.isLoading = false
            switch response {
            case .success(let contents):
                let contentViewModels = contents.map { ContentCollectionViewCellViewModel(content: $0, downloadImageService: strongSelf.downloadImageService) }
                if strongSelf.currentPageIndex == Constant.API.DefaultPageIndex {
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
