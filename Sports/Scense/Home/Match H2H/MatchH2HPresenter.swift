//
//  MatchH2HPresenter.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MatchH2HPresenter: NSObject {
    // MARK: - Properites
    private var view: MatchH2HControllerProtocol?
    private var interactor: MatchH2HPresenterInteractorProtocol?
    private var router: MatchH2HRouterProtocol?
    private var match: Match

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
        
    }
}
// MARK: Conform to MatchH2HInteractorOutputa
extension MatchH2HPresenter: MatchH2HInteractorOutput {
}
