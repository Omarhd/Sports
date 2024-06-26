//
//  MatchStandingPresenter.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MatchStandingPresenter: NSObject {
    // MARK: - Properties
    private var view: MatchStandingControllerProtocol?
    private var interactor: MatchStandingPresenterInteractorProtocol?
    private var router: MatchStandingRouterProtocol?
    private var match: Match
    private var season: StandingSeasonEntity?
    internal var numberOfSections: Int { return SeasonSection.allCases.count }
    private var selectionOptions: [SeasonSelection] = [] /*SeasonSelection.allCases*/
    var selectedOption: SeasonSelection = .short
    
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
        interactor?.fetchSeasonSelectionOptions()
        
        let parameters: StandingSeasonRequest = .init(seasonID: match.details?.seasonDetails?.id ?? "")
        interactor?.fetchSeasonStandingData(with: parameters)
    }
    
    func configureSeasonSelectionCell(for cell: SeasonSelectionTableViewCell, for index: IndexPath, delegate: SeasonSelectionTableViewCellProtocol) {
        let cellData = selectionOptions
        cell.delegate = delegate
        cell.selectedOption = selectedOption
        cell.configureCell(with: cellData)
    }
    
    func configureSeasonTeamCell(for cell: SeasonTeamTableViewCell, for index: IndexPath, with format: SeasonSelection) {
        switch format {
        case .short:
            cell.teamAveragePointCountLabel.isHidden = true
            cell.teamAverageAgainstPointsLabel.isHidden = true
            cell.last10MatchesLabel.isHidden = true
        case .full:
            cell.teamAveragePointCountLabel.isHidden = false
            cell.teamAverageAgainstPointsLabel.isHidden = false
            cell.last10MatchesLabel.isHidden = false
        }
        
        let cellData = season?.standingsData?[index.row]
        
        let homeTeamID = match.details?.homeTeamDetail?.id ?? ""
        let awayTeamID = match.details?.awayTeamDetail?.id ?? ""
        
        homeTeamID == cellData?.teamID ? (cell.contentView.backgroundColor = .lightGray) : ()
        awayTeamID == cellData?.teamID ? (cell.contentView.backgroundColor = .lightGray) : ()
        
        cell.configureCell(with: cellData)
    }
    
    func numberOfRowsInSection(in section: SeasonSection) -> Int {
        switch section {
        case .selection: return 1
        case .teams: return season?.standingsData?.count ?? 0
        }
    }
    
    func heightForRowInSection(in section: SeasonSection) -> CGFloat {
        switch section {
        case .selection: return 60.0
        case .teams: return 80.0
        }
    }
    
    func viewForHeaderInSection(in section: SeasonSection, with header: SeasonStandingHeaderTableViewCell, and format: SeasonSelection) {
        switch section {
        case .selection: break
        case .teams:
            switch format {
            case .short:
                header.teamAveragePointCountLabel.isHidden = true
                header.teamAverageAgainstPointsLabel.isHidden = true
                header.last10MatchesLabel.isHidden = true
            case .full:
                header.teamAveragePointCountLabel.isHidden = false
                header.teamAverageAgainstPointsLabel.isHidden = false
                header.last10MatchesLabel.isHidden = false
            }
        }
    }
    
    func heighForHeaderInSection(in section: SeasonSection) -> CGFloat {
        switch section {
        case .selection: return 0
        case .teams: return 60.0
        }
    }
    
}
// MARK: Conform to MatchStandingInteractorOutput
extension MatchStandingPresenter: MatchStandingInteractorOutput {
    
    func didFetchedSeasonSelectionOptions(options: [SeasonSelection]) {
        selectionOptions = options
    }
    
    func succeedReceivedStandingSeasonData(season: StandingSeasonEntity) {
        self.season = season
        season.standingsData?.isEmpty ?? true ? view?.setEmptyState() : view?.loadTableView()
    }
    
    func didFailedLoadingSeasonData(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
    
    func showLoading() {
        view?.showLoadingIndicator()
    }
    
    func dismissLoading() {
        view?.showFailureIndicator()
    }
}
