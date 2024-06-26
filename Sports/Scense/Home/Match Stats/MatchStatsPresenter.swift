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
    var numberOfSections: Int { return 1 }
    var numberOfRowsInSection: Int { return match.stats?.count ?? 0 }
    
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
        guard let stats = match.stats else { view?.setEmptyView()
            return }
        stats.isEmpty ? (view?.setEmptyView()) : (view?.reloadTableView())
    }
    
    func configureStatCell(for cell: StatTableViewCell, for index: Int) {
        guard let cellData = match.stats, !cellData.isEmpty else { return }
        cell.configureCell(with: cellData[index])
    }
    
}

// MARK: Conform to MatchStatsInteractorOutput
extension MatchStatsPresenter: MatchStatsInteractorOutput {
}
