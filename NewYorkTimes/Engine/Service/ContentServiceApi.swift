//
//  ContentServiceApi.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

protocol ContentServiceApiProtocol {
    func request(pageIndex: UInt, pageSize: UInt, completion: @escaping (Response<[Content]>) -> Void)
}

struct ContentServiceApi {
    fileprivate let request: RequestServiceProtocol
    
    init(request: RequestServiceProtocol) {
        self.request = request
    }
}

// MARK: - ContentServiceApiProtocol

extension ContentServiceApi: ContentServiceApiProtocol {
    func request(pageIndex: UInt, pageSize: UInt, completion: @escaping (Response<[Content]>) -> Void) {
        let api: API = .getContents(pageIndex: pageIndex, pageSize: pageSize)
        
        let responseCompletion: (Response<ContentResponse>) -> Void = { response in
            switch response {
            case .success(let contentResponse):
                switch contentResponse.status {
                case .ok:
                    completion(.success(contentResponse.contents))
                case .unknown:
                    completion(.failure(APIError.serverError.error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        request.object(from: api, completion: responseCompletion)
    }
}
