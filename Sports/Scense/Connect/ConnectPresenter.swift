//
//  ConnectPresenter.swift
//  Sports
//
//  Created by ios Dev on 10/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ConnectPresenter: NSObject {
    // MARK: - Properites
    private var view: ConnectControllerProtocol?
    private var interactor: ConnectPresenterInteractorProtocol?
    private var router: ConnectRouterProtocol?

    // MARK: - Init
    init(view: ConnectControllerProtocol?,
         interactor: ConnectPresenterInteractorProtocol?,
         router: ConnectRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: Conform to ConnectPresenterProtocol
extension ConnectPresenter: ConnectPresenterProtocol {
    func viewDidLoad() {
        
    }
}
// MARK: Conform to ConnectInteractorOutputa
extension ConnectPresenter: ConnectInteractorOutput {
}
