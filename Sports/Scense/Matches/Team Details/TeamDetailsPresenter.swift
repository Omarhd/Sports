//
//  TeamDetailsPresenter.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class TeamDetailsPresenter: NSObject {
    // MARK: - Properites
    private var view: TeamDetailsControllerProtocol?
    private var interactor: TeamDetailsPresenterInteractorProtocol?
    private var router: TeamDetailsRouterProtocol?

    // MARK: - Init
    init(view: TeamDetailsControllerProtocol?,
         interactor: TeamDetailsPresenterInteractorProtocol?,
         router: TeamDetailsRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: Conform to TeamDetailsPresenterProtocol
extension TeamDetailsPresenter: TeamDetailsPresenterProtocol {
    func viewDidLoad() {
        
    }
}
// MARK: Conform to TeamDetailsInteractorOutputa
extension TeamDetailsPresenter: TeamDetailsInteractorOutput {
}
