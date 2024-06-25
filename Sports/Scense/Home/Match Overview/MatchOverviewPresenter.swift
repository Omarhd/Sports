//
//  MatchOverviewPresenter.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MatchOverviewPresenter: NSObject {
    // MARK: - Properites
    private var view: MatchOverviewControllerProtocol?
    private var interactor: MatchOverviewPresenterInteractorProtocol?
    private var router: MatchOverviewRouterProtocol?
    private var match: Match

    // MARK: - Init
    init(view: MatchOverviewControllerProtocol?,
         interactor: MatchOverviewPresenterInteractorProtocol?,
         router: MatchOverviewRouterProtocol?,
         match: Match) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.match = match
    }
}
// MARK: Conform to MatchOverviewPresenterProtocol
extension MatchOverviewPresenter: MatchOverviewPresenterProtocol {
    func viewDidLoad() {
        print(match)
    }
}
// MARK: Conform to MatchOverviewInteractorOutputa
extension MatchOverviewPresenter: MatchOverviewInteractorOutput {
}
