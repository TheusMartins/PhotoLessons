//
//  LessonsRequest.swift
//  LessonsList
//
//  Created by Matheus Martins on 14/01/23.
//

import Network_Layer

enum LessonsRequest {
    case getLessons
}

extension LessonsRequest: RequestInfos {
    var endpoint: String {
        switch self {
        case .getLessons: return "test-api/lessons"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getLessons: return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getLessons: return [:]
        }
    }
}
