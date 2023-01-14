//
//  LessonsModel.swift
//  LessonsList
//
//  Created by Matheus Martins on 14/01/23.
//

import Foundation

struct LessonsModel: Decodable {
    let lessons: [Lesson]
}

struct Lesson: Decodable {
    let id: Int
    let name: String
    let thumbnail: String
    let videoURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case thumbnail
        case videoURL = "video_url"
    }
}
