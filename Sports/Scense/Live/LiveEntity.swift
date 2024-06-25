//
//  LiveEntity.swift
//  Sports
//
//  Created by ios Dev on 20/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

// MARK: - LiveMatchesRequest
struct LiveMatchesRequest: Encodable {
    let pageNumber: Int
    let groupBy: String
    
    enum CodingKeys: String, CodingKey {
        case pageNumber
        case groupBy = "group_by"
    }
    
    init(pageNumber: Int, groupBy: String = "tournament") {
        self.pageNumber = pageNumber
        self.groupBy = groupBy
    }
}
