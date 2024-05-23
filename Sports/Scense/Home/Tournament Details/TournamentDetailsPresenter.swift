//
//  TournamentDetailsPresenter.swift
//  Sports
//
//  Created by ios Dev on 13/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class TournamentDetailsPresenter: NSObject {
    // MARK: - Properites
    private var view: TournamentDetailsControllerProtocol?
    private var interactor: TournamentDetailsPresenterInteractorProtocol?
    private var router: TournamentDetailsRouterProtocol?
    private var tournament: Tournament?
    
    // MARK: - Init
    init(view: TournamentDetailsControllerProtocol?,
         interactor: TournamentDetailsPresenterInteractorProtocol?,
         router: TournamentDetailsRouterProtocol?,
         tournament: Tournament?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.tournament = tournament
    }
}
// MARK: Conform to TournamentDetailsPresenterProtocol
extension TournamentDetailsPresenter: TournamentDetailsPresenterProtocol {
    func viewDidLoad() {
        
    }
}
// MARK: Conform to TournamentDetailsInteractorOutputa
extension TournamentDetailsPresenter: TournamentDetailsInteractorOutput {
}
