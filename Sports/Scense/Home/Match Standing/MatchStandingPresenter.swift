//
//  MatchStandingPresenter.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MatchStandingPresenter: NSObject {
    // MARK: - Properites
    private var view: MatchStandingControllerProtocol?
    private var interactor: MatchStandingPresenterInteractorProtocol?
    private var router: MatchStandingRouterProtocol?
    private var match: Match

    // MARK: - Init
    init(view: MatchStandingControllerProtocol?,
         interactor: MatchStandingPresenterInteractorProtocol?,
         router: MatchStandingRouterProtocol?,
         match: Match) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.match = match
    }
}
// MARK: Conform to MatchStandingPresenterProtocol
extension MatchStandingPresenter: MatchStandingPresenterProtocol {
    func viewDidLoad() {
        
    }
}
// MARK: Conform to MatchStandingInteractorOutputa
extension MatchStandingPresenter: MatchStandingInteractorOutput {
}
