//
//  SignInPresenter.swift
//  Sports
//
//  Created by ios Dev on 06/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class SignInPresenter: NSObject {
    // MARK: - Properties
    private var view: SignInControllerProtocol?
    private var interactor: SignInPresenterInteractorProtocol?
    private var router: SignInRouterProtocol?

    // MARK: - Init
    init(view: SignInControllerProtocol?,
         interactor: SignInPresenterInteractorProtocol?,
         router: SignInRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: Conform to SignInPresenterProtocol
extension SignInPresenter: SignInPresenterProtocol {
    
    func viewDidLoad() {
        
    }

    func signIn(with parameters: SignInRequest) {
        interactor?.signup(with: parameters)
    }
    
    func pushToSignup() {
        router?.showSignupViewController()
    }
}

// MARK: Conform to SignInInteractorOutput
extension SignInPresenter: SignInInteractorOutput {

    func succeedSignIn(signInEntity: SignInEntity) {
//        router?.showVerificationPage(with: signupEntity.data?.token ?? "")
    }
    
    func didFailedSignIn(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
    
    func showLoading() {
        view?.showLoadingIndicator()
    }
    
    func dismissLoading() {
        view?.showFailureIndicator()
    }
}
