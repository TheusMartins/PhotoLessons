//
//  RequestInfos.swift
//  
//
//  Created by Matheus Martins on 14/01/23.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

public protocol RequestInfos {
    
    var baseURL: URL { get }
    
    var endpoint: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: [String: Any]? { get }

}

public extension RequestInfos {
    var baseURL: URL {
        return URL(string: "https://iphonephotographyschool.com/")!
    }
}

