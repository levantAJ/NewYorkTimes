//
//  ContentServiceApi.swift
//  NewYorkTimes
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

protocol ContentServiceApiProtocol {
    func request(pageIndex: UInt, pageSize: UInt, completion: @escaping (Response<[Content]?>) -> Void)
}

struct ContentServiceApi {
    fileprivate let request: RequestServiceProtocol
    
    init(request: RequestServiceProtocol) {
        self.request = request
    }
}

// MARK: - ContentServiceApiProtocol

extension ContentServiceApi: ContentServiceApiProtocol {
    func request(pageIndex: UInt, pageSize: UInt, completion: @escaping (Response<[Content]?>) -> Void) {
        let api: API = .getContents(pageIndex: pageIndex, pageSize: pageSize)
        request.array(from: api, completion: completion)
    }
}
