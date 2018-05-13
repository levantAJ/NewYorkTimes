//
//  SearchArticlesServiceApi.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

protocol SearchArticlesServiceApiProtocol {
    
}

final class SearchArticlesServiceApi {
    fileprivate let request: RequestServiceProtocol
    
    init(request: RequestServiceProtocol) {
        self.request = request
    }
}

// MARK: - SearchArticlesServiceApiProtocol

extension SearchArticlesServiceApi: SearchArticlesServiceApiProtocol {
    func search(query: String, pageIndex: UInt) {
//        let responseCompletion: (Response<ContentResponse>) -> Void = { response in
//            switch response {
//            case .success(let contentResponse):
//                switch contentResponse.status {
//                case .ok:
//                    completion(.success(contentResponse.contents))
//                case .unknown:
//                    completion(.failure(APIError.serverError.error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//        
//        let api: API = .searchArticles(query: query, pageIndex: pageIndex)
//        request.object(from: api) { (response) in
//            
//        }
    }
}
