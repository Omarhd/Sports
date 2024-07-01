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
    .init(title: "Highlight 1", imageURL: "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5"),
    .init(title: "Highlight 2", imageURL: "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5"),
    .init(title: "Highlight 3", imageURL: "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5"),
    .init(title: "Highlight 4", imageURL: "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5"),
    .init(title: "Highlight 5", imageURL: "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5"),
    .init(title: "Highlight 6", imageURL: "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5"),
    .init(title: "Highlight 7", imageURL: "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5"),
    .init(title: "Highlight 8", imageURL: "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5"),
    .init(title: "Highlight 9", imageURL: "https://walker-web.imgix.net/cms/Gradient_builder_2.jpg?auto=format,compress&w=1920&h=1200&fit=crop&dpr=1.5")
  ]
