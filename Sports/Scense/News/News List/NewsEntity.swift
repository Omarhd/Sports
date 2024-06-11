//
//  NewsEntity.swift
//  Sports
//
//  Created by ios Dev on 23/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - News Request
struct NewsRequest: Encodable {
    let pageNumber: Int
}

// MARK: - NewsEntity
struct NewsEntity: Codable {
    let list: [News]?
    let meta: Meta?
}

// MARK: - News
struct News: Codable {
    let id, adminID, category, cover: Int?
    let browse, sort, status, translate: Int?
    let createTime, updateTime, title, description, content: String?
    let keywords: String?
    let path: String?
    let slugURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case adminID = "admin_id"
        case category, cover, browse, sort, status, translate
        case createTime = "create_time"
        case updateTime = "update_time"
        case title, description, content, keywords, path
        case slugURL = "slug_url"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let locale: String?
    let currentPage, lastPage, perPage, total: Int?
}
