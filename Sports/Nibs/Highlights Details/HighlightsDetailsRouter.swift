//
//  HighlightsDetailsRouter.swift
//  Sports
//
//  Created by ios Dev on 01/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class HighlightsDetailsRouter {
    weak var viewController: HighlightsDetailsViewController?

    // MARK: - Init
    init(viewController: HighlightsDetailsViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to HighlightsDetailsRouterProtocol
extension HighlightsDetailsRouter: HighlightsDetailsRouterProtocol {
   
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func showFullImage(image: UIImage) {
        let detailsViewController = ImageViewerViewController(image: image)
        viewController?.showHero(detailsViewController, navigationAnimationType: .auto)
    }
}
