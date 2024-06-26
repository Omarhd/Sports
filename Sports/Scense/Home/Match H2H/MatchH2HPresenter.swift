//
//  MatchH2HPresenter.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MatchH2HPresenter: NSObject {
    // MARK: - Properties
    private var view: MatchH2HControllerProtocol?
    private var interactor: MatchH2HPresenterInteractorProtocol?
    private var router: MatchH2HRouterProtocol?
    
    private var match: Match
    private var history: History?
    private var selectionOptions: [TeamSelection] = [] /*TeamSelection.allCases*/
    internal var numberOfSections: Int { return H2HSection.allCases.count }
    var selectedOption: TeamSelection = .vs
    
    // MARK: - Init
    init(view: MatchH2HControllerProtocol?,
         interactor: MatchH2HPresenterInteractorProtocol?,
         router: MatchH2HRouterProtocol?,
         match: Match) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.match = match
    }
}
// MARK: Conform to MatchH2HPresenterProtocol
extension MatchH2HPresenter: MatchH2HPresenterProtocol {

    func viewDidLoad() {
        interactor?.fetchH2HSelectionOptions()
        let parameters: HeadToHeadRequest = .init(matchID: match.id ?? "",
                                                  homeTeamID: match.details?.homeTeamDetail?.id ?? "",
                                                  awayTeamID: match.details?.awayTeamDetail?.id ?? "")
        interactor?.fetchH2HData(with: parameters)
    }
    
    func numberOfRowsInSection(in section: H2HSection) -> Int {
        switch section {
        case .selection: return 1
        case .matches:
            switch selectedOption {
            case .vs:
                return history?.vs?.count ?? 0
            case .home:
                return history?.home?.count ?? 0
            case .away:
                return history?.away?.count ?? 0
            }
        }
    }
    
    func heightForRowInSection(in section: H2HSection) -> CGFloat {
        switch section {
        case .selection: return 60.0
        case .matches: return 120.0
        }
    }
    
    func configureH2HVersesMatchCell(for cell: MatchH2HTableViewCell, for index: IndexPath) {
        var cellData: H2HMatch?
        
        switch selectedOption {
        case .vs:
            cellData = history?.vs?[index.row]
        case .home:
            cellData = history?.home?[index.row]
        case .away:
            cellData = history?.away?[index.row]
        }
        
        cell.configureCell(with: cellData)
    }
    
    func configureH2HSelectionCell(for cell: MatchH2HSelectionTableViewCell, for index: IndexPath, delegate: MatchH2HSelectionTableViewCellProtocol) {
        let cellData = selectionOptions
        cell.delegate = delegate
        cell.selectedOption = selectedOption
        cell.configureCell(with: cellData)
    }

}
// MARK: Conform to MatchH2HInteractorOutput
extension MatchH2HPresenter: MatchH2HInteractorOutput {
    
    func didFetchedH2HSelectionOptions(options: [TeamSelection]) {
        selectionOptions = options
    }
    
    func succeedReceivedH2HData(h2hData: MatchH2HEntity) {
        history = h2hData.results?.history
        history?.vs?.isEmpty ?? true ? view?.setEmptyState() : view?.loadTableView()
    }
    
    func didFailedLoadingH2HData(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
    
    func showLoading() {
        view?.showLoadingIndicator()
    }
    
    func dismissLoading() {
        view?.showFailureIndicator()
    }
    
}
