//
//  URLSessionMock.swift
//  NewYorkTimesTests
//
//  Created by levantAJ on 12/5/18.
//  Copyright © 2018 levantAJ. All rights reserved.
//

import Foundation
@testable import NewYorkTimes

final class URLSessionDataTaskMock: URLSessionDataTask {
    override func resume() {
        //Overriding method
    }
}

class URLSessionMock: URLSessionProtocol {
    
    var completion: ((Data?, URLResponse?, Error?) -> Void)?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completion = completionHandler
        return URLSessionDataTaskMock()
    }
}
