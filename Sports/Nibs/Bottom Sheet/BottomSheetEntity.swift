//
//  BottomSheetEntity.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class BottomSheetEntity {
    
}

enum CreateContentOptions: Int, CaseIterable {
    case Post = 0
    case Story = 1
    case Moment = 2
    
    var description: String {
        switch self {
        case .Post: return "Post"
        case .Story: return "Quick Story"
        case .Moment: return "Moment"
        }
    }
}
