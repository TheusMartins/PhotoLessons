//
//  RequestProtocolSpy.swift
//  Network LayerTests
//
//  Created by Matheus Martins on 14/01/23.
//

import Network_Layer

final class RequestProtocolSpy: URLSession {
    var requests = [(request: URLRequest, completion: (Data?, URLResponse?, Error?) -> Void)]()
    
    var shouldBeSuccess = true

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Swift.Error?) -> Void) -> URLSessionDataTask {
        let response: (Data?, URLResponse?, Error?) = shouldBeSuccess ? (Data("some data".utf8),
                                                                         URLResponse(url: request.url!, mimeType: "", expectedContentLength: 0, textEncodingName: nil),
                                                                         nil) :
                                                                        (nil, nil, NSError(domain: "Test", code: 1))
        requests.append((request, completionHandler))
        
        return URLSessionDataTaskMock {
            completionHandler(response.0, response.1, response.2)
        }
    }
}

final class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
