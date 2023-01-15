//
//  LessonsModel.swift
//  LessonsList
//
//  Created by Matheus Martins on 14/01/23.
//

import Foundation

public struct LessonsModel: Decodable {
    let lessons: [Lesson]
    var uiModel: [LessonUIModel] {
        lessons.map { LessonUIModel(id: $0.id, name: $0.name, thumbnail: $0.thumbnail, videoURL: $0.videoURL) }
    }
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
