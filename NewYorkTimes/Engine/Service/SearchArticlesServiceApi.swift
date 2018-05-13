//
//  SearchArticlesServiceApi.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 13/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

protocol SearchArticlesServiceApiProtocol {
    func search(query: String, pageIndex: UInt, completion: @escaping (Response<[Article]>) -> Void)
}

final class SearchArticlesServiceApi {
    fileprivate let request: RequestServiceProtocol
    
    init(request: RequestServiceProtocol) {
        self.request = request
    }
}

// MARK: - SearchArticlesServiceApiProtocol

extension SearchArticlesServiceApi: SearchArticlesServiceApiProtocol {
    func search(query: String, pageIndex: UInt, completion: @escaping (Response<[Article]>) -> Void) {
        let responseCompletion: (Response<SearchArticlesResponse>) -> Void = { response in
            switch response {
            case .success(let searchArticlesResponse):
                switch searchArticlesResponse.status {
                case .ok:
                    completion(.success(searchArticlesResponse.articles ?? []))
                case .unknown:
                    completion(.failure(APIError.serverError.error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        let api: API = .searchArticles(query: query, pageIndex: pageIndex)
        request.object(from: api, completion: responseCompletion)
    }
}
