//
//  MatchOddsPresenter.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MatchOddsPresenter: NSObject {
    // MARK: - Properties
    private var view: MatchOddsControllerProtocol?
    private var interactor: MatchOddsPresenterInteractorProtocol?
    private var router: MatchOddsRouterProtocol?
    private var match: Match

    // MARK: - Init
    init(view: MatchOddsControllerProtocol?,
         interactor: MatchOddsPresenterInteractorProtocol?,
         router: MatchOddsRouterProtocol?,
         match: Match) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.match = match
    }
}
// MARK: Conform to MatchOddsPresenterProtocol
extension MatchOddsPresenter: MatchOddsPresenterProtocol {
    func viewDidLoad() {
        
    }
}
// MARK: Conform to MatchOddsInteractorOutputa
extension MatchOddsPresenter: MatchOddsInteractorOutput {
}
