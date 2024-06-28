//
//  DetailsPagesInteractor.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class DetailsPagesInteractor {

    var presenter: DetailsPagesInteractorOutput?

    init() {
    }
}
extension DetailsPagesInteractor: DetailsPagesPresenterInteractorProtocol {
    
    func fetchPages(with match: Match) {
        let overview = MatchOverviewConfigurator.viewController(input: .init(match: match))
        let stats = MatchStatsConfigurator.viewController(input: .init(match: match))
        let odds = MatchOddsConfigurator.viewController(input: .init(match: match))
        let h2h = MatchH2HConfigurator.viewController(input: .init(match: match))
        let standing = MatchStandingConfigurator.viewController(input: .init(match: match))
        
        presenter?.didFetchPages([overview, stats, odds, h2h, standing])
    }
}

