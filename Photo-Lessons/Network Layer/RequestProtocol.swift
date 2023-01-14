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
            completionHandler(.failure(RequestErrors.invalidURL))
            return
        }
        
        var components: [URLQueryItem] = []
        
        requestInfos.parameters?.forEach({ key, value in
            components.append(URLQueryItem(name: key, value: "\(value)"))
        })
        
        url.queryItems = components
        
        guard let finalURL = url.url else {
            completionHandler(.failure(RequestErrors.invalidURL))
            return
        }
        
        let request = URLRequest(url: finalURL)
        session.dataTask(with: request) { data, resp, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data, let resp = resp else {
                completionHandler(.failure(RequestErrors.invalidData))
                return
            }
            
            completionHandler(.success((data, resp)))

        }.resume()
    }
}

public enum RequestErrors: Error {
    case invalidURL
    case connectivity
    case invalidData
}
