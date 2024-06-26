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
    var numberOfSections: Int { return MatchOverviewSection.allCases.count }

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
        view?.reloadSection()
    }
    
    func numberOfCells(in section: MatchOverviewSection) -> Int {
        switch section {
        case .venue: return 1
        case .weather: return 1
        case .tournament: return 1
        }
    }
    
    func heightForRowInSection(in section: MatchOverviewSection) -> CGFloat {
        switch section {
        case .venue: return 200
        case .weather: return 200
        case .tournament: return 200
        }
    }
    
    func configureVenueCell(with cell: VenueTableViewCell, for indexPath: IndexPath) {
        guard let venue = match.details?.venueDetails else { return }
        cell.configureCellUI(venue: venue)
    }
    
    func configureWeatherCell(with cell: WeatherTableViewCell, for indexPath: IndexPath) {
        guard let weather = match.details?.matchDetails?.weather else { return }
        cell.configureCellUI(weather: weather)
    }
    
    func configureTournamentCell(with cell: TournamentTableViewCell, for indexPath: IndexPath) {
        guard let tournament = match.details?.tournamentDetails else { return }
        cell.configureCellUI(tournament: tournament)
    }
}

// MARK: Conform to MatchOverviewInteractorOutput
extension MatchOverviewPresenter: MatchOverviewInteractorOutput {
}
