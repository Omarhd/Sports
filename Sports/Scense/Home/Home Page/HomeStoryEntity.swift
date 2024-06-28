//
//  HomeStoryEntity.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//

import Foundation

struct HomeStoryEntity: Decodable {
    let name: String
    let imageURL: String
}

let stories: [HomeStoryEntity] = [.init(name: "Ahmed", imageURL: ""),
                                  .init(name: "Omar", imageURL: ""),
                                  .init(name: "Ali", imageURL: ""),
                                  .init(name: "Alaa", imageURL: ""),
                                  .init(name: "Jesus", imageURL: ""),
                                  .init(name: "Others", imageURL: ""),
                                  .init(name: "Ahmed", imageURL: ""),
                                  .init(name: "Ahmed", imageURL: ""),
                                  .init(name: "Ahmed", imageURL: "")]
