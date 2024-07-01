//
//  Enums.swift
//  Sports
//
//  Created by ios Dev on 28/06/2024.
//

import Foundation
import UIKit

enum BottomSheetDetent {
    case medium
    case custom(CGFloat)
    
    var detent: Any {
        if #available(iOS 16.0, *) {
            switch self {
            case .medium:
                return UISheetPresentationController.Detent.medium()
            case .custom(let height):
                return UISheetPresentationController.Detent.custom(identifier: .medium) { _ in
                    return height
                }
            }
        } else {
            // Fallback for earlier versions
            return UISheetPresentationController.Detent.medium()
        }
    }
}
