//
//  HomeHighlightsEntity.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//

import Foundation

struct HomeHighlightsEntity: Decodable {
    let title: String
    let imageURL: String?
}

let highlights: [HomeHighlightsEntity] = [
    .init(title: "Highlight 1", imageURL: "imageURL1"),
    .init(title: "Highlight 2", imageURL: "imageURL2"),
    .init(title: "Highlight 3", imageURL: "imageURL3"),
    .init(title: "Highlight 4", imageURL: "imageURL4"),
    .init(title: "Highlight 5", imageURL: "imageURL5"),
    .init(title: "Highlight 6", imageURL: "imageURL6"),
    .init(title: "Highlight 7", imageURL: "imageURL7"),
    .init(title: "Highlight 8", imageURL: "imageURL8"),
    .init(title: "Highlight 9", imageURL: "imageURL9")
  ]
