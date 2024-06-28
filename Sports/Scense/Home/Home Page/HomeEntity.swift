//
//  HomeEntity.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct HomeEntity: Decodable {
    let post: [Post]
}

struct Post: Decodable {
    let id: Int
    let content: String
    let imageURL: String
    let user: User
}

struct User: Decodable {
    let name: String
    let imageURL: String
    let username: String
    let followed: Bool
}

// Creating a sample instance
let user = User(name: "John Doe", imageURL: "userImageURL", username: "johndoe123", followed: true)
let post = Post(id: 1,
                content: "Today's game showed how great Team India is. With passion and dedication, they continue to fight and achieve. Proud to be part of this journey! IndiaBasketball #ShineOn #HoopsHeroes",
                imageURL: "https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1240w,f_auto,q_auto:best/rockcms/2024-06/240626-Zaccharie-Risacher-nba-draft-ac-819p-76185c.jpg", user: user)
let homeEntity = HomeEntity(post: [post, post, post, post, post, post])

enum HomeSections: Int, CaseIterable {
    case stories
    case highlightNews
    case posts
}
