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
    let imageURL: String?
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

let post2 = Post(id: 2,
                content: "This trade provides us with a mix of young and veteran players, as well as future flexibility and draft assets, as we continue our quest to win, and so we’re pleased to welcome Davion, Sasha and Jamal to the Raptors and to Toronto,” Raptors general manager Bobby Webster said in a team statement. “We thank Jalen for his contributions, and we wish him all the best in the future.A lottery pick in 2021, Mitchell has seen his role steadily decline in Sacramento. Last season, he averaged 5.3 points, 1.3 rebounds and 1.9 assists in 15.3 minutes per game, a far cry from the 11.5 ppg, 2.2 spg and 4.2 apg he averaged in 27.7 mpg as a rookie. However, Mitchell played strong after the All-Star break and was a key player for Sacramento, which made the Play-In Tournament. In 28 games after the All-Star break, Mitchell posted 7.4 ppg, 1.8 rpg and 2.1 apg in 18.6 minutes per game. McDaniels signed a two-year deal with the Raptors last summer and appeared in 50 games, averaging 3.4 ppg and 1.6 rpg in 10.8 mpg. He struggled offensively, shooting 34.4% overall after averaging 45.5% in 2022-23. He saw his role increase after the All-Star break (14.3 mpg, 4.4 ppg, 2.2 rpg, 1.2 apg) but the Raptors were out of contention for the postseason by early March. Vezenkov, a rookie in 2023-24, was the EuroLeague MVP in 2022-23 and signed a three-year deal with the Kings last summer. He appeared in 42 games (12.2 mpg, 4.5 ppg, 2.3 rpg) but competed for frontcourt minutes with veterans such as Harrison Barnes, Malik Monk, Kevin Huerter and Trey Lyles.",
                imageURL: "https://cdn.nba.com/manage/2024/01/GettyImages-2158847399-scaled-e1719459595813-1568x883.jpg", user: user)

let post3 = Post(id: 3,
                content: "New Grizzlies center Zach Edey announced his decision Sunday to pull his name from consideration to play for Canada in the 2024 Paris Olympics to focus on his NBA career. Memphis used the ninth overall selection on the former Purdue center, who became the first player in more than 40 years to win The Associated Press’ men’s college basketball player of the year award in back-to-back seasons. The 7-foot-4 Edey called it a difficult decision not to compete for a spot in the Paris Games. Edey said he has been training nonstop since last summer to win a national title at Purdue and make it to the NBA.",
                imageURL: "",
                 user: user)

let homeEntity = HomeEntity(post: [post, post2, post3])

enum HomeSections: Int, CaseIterable {
    case stories
    case highlightNews
    case posts
}
