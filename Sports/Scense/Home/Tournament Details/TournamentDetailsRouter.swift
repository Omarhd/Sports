//
//  TournamentDetailsRouter.swift
//  Sports
//
//  Created by ios Dev on 13/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class TournamentDetailsRouter {
    weak var viewController: TournamentDetailsViewController?

    // MARK: - Init
    init(viewController: TournamentDetailsViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to TournamentDetailsRouterProtocol
extension TournamentDetailsRouter: TournamentDetailsRouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
