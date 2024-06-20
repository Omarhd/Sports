//
//  MatchDetailsPresenter.swift
//  Sports
//
//  Created by ios Dev on 19/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MatchDetailsPresenter: NSObject {
    
    // MARK: - Properties
    private var view: MatchDetailsControllerProtocol?
    private var interactor: MatchDetailsPresenterInteractorProtocol?
    private var router: MatchDetailsRouterProtocol?
    private var match: Match

    // MARK: - Init
    init(view: MatchDetailsControllerProtocol?,
         interactor: MatchDetailsPresenterInteractorProtocol?,
         router: MatchDetailsRouterProtocol?,
         match: Match) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.match = match
    }
}

// MARK: Conform to MatchDetailsPresenterProtocol
extension MatchDetailsPresenter: MatchDetailsPresenterProtocol {

    func viewDidLoad() {
        print(match)
    }
}

// MARK: Conform to MatchDetailsInteractorOutput
extension MatchDetailsPresenter: MatchDetailsInteractorOutput {
}
