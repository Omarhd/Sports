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
    private var tabs: [Tabs] = []
    var allTabs: [Tabs] { return self.tabs }
    var selectedTabIndex: Int = 0

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
        interactor?.fetchTabs()
        view?.configureMatchStatusUI(matchStatus: self.match.details?.matchDetails?.statusID ?? .abnormal, match: self.match)
        view?.configureTeamsUI(with: self.match)
        view?.configurePageController(with: self.match)
        view?.highlightSelectedTab(for: selectedTabIndex)
        view?.configurePageController(with: self.match)
    }
    
    func configureTabsCell(with cell: TabCollectionViewCell, for index: Int) {
        cell.isSelected = index == selectedTabIndex
        let cellData = self.tabs[index].rawValue
        cell.configureTab(tab: cellData)
    }
    
    func didSelectTab(for index: Int) {
        selectedTabIndex = index
        view?.highlightSelectedTab(for: index)
        NotificationCenter.default.post(name: .selectedTabIndexChanged, object: nil, userInfo: ["selectedTabIndex": selectedTabIndex])
    }
    
    func updateCollection(with index: Int) {
        selectedTabIndex = index
        view?.highlightSelectedTab(for: index)
    }
}

// MARK: Conform to MatchDetailsInteractorOutput
extension MatchDetailsPresenter: MatchDetailsInteractorOutput {
   
    func didFetchTabs(_ tabs: [Tabs]) {
        self.tabs = tabs
    }
}


