//
//  MatchDetailsInteractor.swift
//  Sports
//
//  Created by ios Dev on 19/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchDetailsInteractor {

    var presenter: MatchDetailsInteractorOutput?

    init() {
    }
}
extension MatchDetailsInteractor: MatchDetailsPresenterInteractorProtocol {
    
    func fetchTabs() {
        let tabs: [Tabs] = [.overview, .stats, .odds, .h2h, .standing]
        presenter?.didFetchTabs(tabs)
    }
    

}

