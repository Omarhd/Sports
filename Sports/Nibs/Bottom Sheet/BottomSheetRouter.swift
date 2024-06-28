//
//  BottomSheetRouter.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class BottomSheetRouter {
    weak var viewController: BottomSheetViewController?

    // MARK: - Init
    init(viewController: BottomSheetViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to BottomSheetRouterProtocol
extension BottomSheetRouter: BottomSheetRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
