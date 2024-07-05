//
//  ConfirmOTPPresenter.swift
//  Sports
//
//  Created by ios Dev on 04/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ConfirmOTPPresenter: NSObject {
    // MARK: - Properties
    private var view: ConfirmOTPControllerProtocol?
    private var interactor: ConfirmOTPPresenterInteractorProtocol?
    private var router: ConfirmOTPRouterProtocol?
    let token: String

    // MARK: - Init
    init(view: ConfirmOTPControllerProtocol?,
         interactor: ConfirmOTPPresenterInteractorProtocol?,
         router: ConfirmOTPRouterProtocol?,
         token: String) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.token = token
    }
}
// MARK: Conform to ConfirmOTPPresenterProtocol
extension ConfirmOTPPresenter: ConfirmOTPPresenterProtocol {
    func viewDidLoad() {
    }
}
// MARK: Conform to ConfirmOTPInteractorOutput
extension ConfirmOTPPresenter: ConfirmOTPInteractorOutput {
}
