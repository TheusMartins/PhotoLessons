//
//  RequestProtocol.swift
//  
//
//  Created by Matheus Martins on 14/01/23.
//

import Foundation

public protocol RequestProtocol {
    typealias RequestResult = Result<(Data, URLResponse), Error>
    func requestData(requestInfos: RequestInfos, completionHandler: @escaping (RequestResult) -> Void)
}

public final class Request: RequestProtocol {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func requestData(requestInfos: RequestInfos, completionHandler: @escaping (RequestResult) -> Void) {
        guard var url = URLComponents(string: "\(requestInfos.baseURL)\(requestInfos.endpoint)") else {
            completionHandler(.failure(NSError()))
            return
        }
        
        var components: [URLQueryItem] = []
        
        requestInfos.parameters?.forEach({ key, value in
            components.append(URLQueryItem(name: key, value: "\(value)"))
        })
        
        url.queryItems = components
        
        guard let finalURL = url.url else {
            completionHandler(.failure(NSError()))
            return
        }
        
        session.dataTask(with: finalURL) { data, resp, error in
            if let error = error {
                completionHandler(.failure(error))
            }
            
            guard let data = data, let resp = resp else {
                completionHandler(.failure(NSError()))
                return
            }
            
            completionHandler(.success((data, resp)))

        }.resume()
    }
}
