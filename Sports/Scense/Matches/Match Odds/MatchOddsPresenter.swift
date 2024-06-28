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
    private var odds: MatchOddsEntity?
    internal var numberOfSections: Int { return OddsSection.allCases.count }
    private var selectionOptions: [OddsSelection] = [] /*OddsSelection.allCases*/
    var selectedOption: OddsSelection = .spread

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
        interactor?.fetchOddsSelectionOptions()
        
        let parameters: OddsRequest = .init(matchID: match.id ?? "")
        interactor?.fetchOddsData(with: parameters)
    }
    
    func configureOddsSelectionCell(for cell: MatchOddsSelectionTableViewCell, for index: IndexPath, delegate: MatchOddsSelectionTableViewCellProtocol) {
        let cellData = selectionOptions
        cell.delegate = delegate
        cell.selectedOption = selectedOption
        cell.configureCell(with: cellData)
    }
    
    func configureOddsMatchCell(for cell: MatchOddsTableViewCell, for index: IndexPath) {
        var cellData: [DatumUnion]?

        switch selectedOption {
        case .spread:
            if let spreadData = odds?.data?.filter({ $0.code == .asia }), index.row < spreadData.count {
                cellData = spreadData[index.row].data?.flatMap { $0 }
            }
        case .toWin:
            if let toWinData = odds?.data?.filter({ $0.code == .eu }), index.row < toWinData.count {
                cellData = toWinData[index.row].data?.flatMap { $0 }
            }
        case .totalPoints:
            if let totalPointsData = odds?.data?.filter({ $0.code == .bs }), index.row < totalPointsData.count {
                cellData = totalPointsData[index.row].data?.flatMap { $0 }
            }
        }

        cell.configureCell(with: cellData)
    }


    
    func numberOfRowsInSection(in section: OddsSection) -> Int {
        switch section {
        case .selection: return 1
        case .odds:
            switch selectedOption {
            case .spread: return odds?.data?.filter { $0.code == .asia }.count ?? 0
            case .toWin: return odds?.data?.filter { $0.code == .bs }.count ?? 0
            case .totalPoints: return odds?.data?.filter { $0.code == .eu }.count ?? 0
            }
        }
    }
    
    func heightForRowInSection(in section: OddsSection) -> CGFloat {
        switch section {
        case .selection: return 80
        case .odds: return 100
        }
    }
}

// MARK: Conform to MatchOddsInteractorOutput
extension MatchOddsPresenter: MatchOddsInteractorOutput {
    
    func didFetchedOddsSelectionOptions(options: [OddsSelection]) {
        selectionOptions = options
    }
    
    func succeedReceivedOddsData(odds: MatchOddsEntity) {
        self.odds = odds
        odds.data?.isEmpty ?? true ? view?.setEmptyState() : view?.loadTableView()
    }
    
    func didFailedLoadingOddsData(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
    
    func showLoading() {
        view?.showLoadingIndicator()
    }
    
    func dismissLoading() {
        view?.showFailureIndicator()
    }
    
}
