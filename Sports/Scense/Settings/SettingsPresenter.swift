//
//  SettingsPresenter.swift
//  Sports
//
//  Created by ios Dev on 24/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class SettingsPresenter: NSObject {
    // MARK: - Properites
    private var view: SettingsControllerProtocol?
    private var interactor: SettingsPresenterInteractorProtocol?
    private var router: SettingsRouterProtocol?

    // MARK: - Init
    init(view: SettingsControllerProtocol?,
         interactor: SettingsPresenterInteractorProtocol?,
         router: SettingsRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: Conform to SettingsPresenterProtocol
extension SettingsPresenter: SettingsPresenterProtocol {
    func viewDidLoad() {
        
    }
}
// MARK: Conform to SettingsInteractorOutputa
extension SettingsPresenter: SettingsInteractorOutput {
}
