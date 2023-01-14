//
//  LessonsModel.swift
//  LessonsList
//
//  Created by Matheus Martins on 14/01/23.
//

import Foundation

public struct LessonsModel: Decodable {
    public let lessons: [Lesson]
}

public struct Lesson: Decodable {
    public let id: Int
    public let name: String
    public let thumbnail: String
    public let videoURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case thumbnail
        case videoURL = "video_url"
    }
}
