//
//  Lesson.swift
//  ArtiumLessonsApp
//
//  Created by Admin on 07/05/25.
//

import Foundation

struct LessonsResponse: Codable {
    let lessons: [Lesson]
}

struct Lesson: Codable, Identifiable {
    let id = UUID()
    let mentorName: String
    let lessonTitle: String
    let videoThumbnailURL: String
    let lessonImageURL: String
    let videoURL: String

    enum CodingKeys: String, CodingKey {
        case mentorName = "mentor_name"
        case lessonTitle = "lesson_title"
        case videoThumbnailURL = "video_thumbnail_url"
        case lessonImageURL = "lesson_image_url"
        case videoURL = "video_url"
    }
}
