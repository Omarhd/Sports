//
//  HomePresenter.swift
//  Sports
//
//  Created by ios Dev on 09/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HomePresenter: NSObject {
    // MARK: - Properties
    private var view: HomeControllerProtocol?
    private var interactor: HomePresenterInteractorProtocol?
    private var router: HomeRouterProtocol?
    
    var tournaments: [Result] = []
    var numberOfTournament: Int { return tournaments.count }
    
    // MARK: - Init
    init(view: HomeControllerProtocol?,
         interactor: HomePresenterInteractorProtocol?,
         router: HomeRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: Conform to HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        let parameters: TournamentRequest = TournamentRequest(pageNumber: 1)
        interactor?.fetchHotMatches(parameters: parameters)
    }
    
    func configureCell(with cell: TournamentTableViewCell, for index: Int) {
        let cellData = tournaments[index]
        cell.displayName(name: cellData.name ?? "")
    }
    
    func didSelect(for index: Int) {
        let cellData = tournaments[index]
        router?.navigateToDetails()
    }
}
// MARK: Conform to HomeInteractorOutput
extension HomePresenter: HomeInteractorOutput {
    
    func succeedReceivedTournaments(tournamentData: HomeEntity) {
        tournaments = tournamentData.results ?? []
        tournamentData.results?.isEmpty ?? false ? (view?.setEmptyState()) : (view?.loadTableView())
    }
    
    func didFailedLoadingTournaments(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
}
