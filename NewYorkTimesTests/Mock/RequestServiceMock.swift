//
//  RequestServiceMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

@testable import NewYorkTimes

final class RequestServiceMock<TMock: Mappable>: RequestServiceProtocol {
    var objectCompletion: ((Response<TMock>) -> Void)?
    var arrayCompletion: ((Response<[TMock]?>) -> Void)?
    
    func object<T>(from api: API, completion: @escaping (Response<T>) -> Void) {
        objectCompletion = { response in
            switch response {
            case .success(let value):
                completion(.success(value as! T))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func array<T>(from api: API, completion: @escaping (Response<[T]>) -> Void) {
        arrayCompletion = { response in
            switch response {
            case .success(let value):
                completion(.success(value as! [T]))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
