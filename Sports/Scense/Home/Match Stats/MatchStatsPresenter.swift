//
//  MatchStatsPresenter.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MatchStatsPresenter: NSObject {
    // MARK: - Properties
    private var view: MatchStatsControllerProtocol?
    private var interactor: MatchStatsPresenterInteractorProtocol?
    private var router: MatchStatsRouterProtocol?
    private var match: Match
    
    // MARK: - Init
    init(view: MatchStatsControllerProtocol?,
         interactor: MatchStatsPresenterInteractorProtocol?,
         router: MatchStatsRouterProtocol?,
         match: Match) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.match = match
    }
}
// MARK: Conform to MatchStatsPresenterProtocol
extension MatchStatsPresenter: MatchStatsPresenterProtocol {
    func viewDidLoad() {
        
    }
}
// MARK: Conform to MatchStatsInteractorOutputa
extension MatchStatsPresenter: MatchStatsInteractorOutput {
}
