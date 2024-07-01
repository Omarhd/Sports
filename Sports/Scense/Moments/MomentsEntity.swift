//
//  MomentsEntity.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct MomentsEntity: Decodable {
    let videoThumbnail: String
    let videoLength: String
    let videoURL: String
    let user: User
}

let moments: [MomentsEntity] = [
    .init(videoThumbnail: "thumbnail1.jpg", videoLength: "2:30", videoURL: "http://example.com/video1.mp4", user: user),
    .init(videoThumbnail: "thumbnail2.jpg", videoLength: "1:45", videoURL: "http://example.com/video2.mp4", user: user),
    .init(videoThumbnail: "thumbnail3.jpg", videoLength: "3:15", videoURL: "http://example.com/video3.mp4", user: user),
    .init(videoThumbnail: "thumbnail4.jpg", videoLength: "2:05", videoURL: "http://example.com/video4.mp4", user: user),
    .init(videoThumbnail: "thumbnail5.jpg", videoLength: "1:55", videoURL: "http://example.com/video5.mp4", user: user),
    .init(videoThumbnail: "thumbnail6.jpg", videoLength: "2:40", videoURL: "http://example.com/video6.mp4", user: user),
    .init(videoThumbnail: "thumbnail7.jpg", videoLength: "3:00", videoURL: "http://example.com/video7.mp4", user: user),
    .init(videoThumbnail: "thumbnail8.jpg", videoLength: "1:50", videoURL: "http://example.com/video8.mp4", user: user),
    .init(videoThumbnail: "thumbnail9.jpg", videoLength: "2:20", videoURL: "http://example.com/video9.mp4", user: user),
    .init(videoThumbnail: "thumbnail10.jpg", videoLength: "2:10", videoURL: "http://example.com/video10.mp4", user: user)
]

enum MomentsSections: Int, CaseIterable {
    case following = 0
    case highlight = 1
}
