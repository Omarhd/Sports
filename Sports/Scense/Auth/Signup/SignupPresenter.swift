//
//  SignupPresenter.swift
//  Sports
//
//  Created by ios Dev on 04/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class SignupPresenter: NSObject {
    // MARK: - Properties
    private var view: SignupControllerProtocol?
    private var interactor: SignupPresenterInteractorProtocol?
    private var router: SignupRouterProtocol?

    // MARK: - Init
    init(view: SignupControllerProtocol?,
         interactor: SignupPresenterInteractorProtocol?,
         router: SignupRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: Conform to SignupPresenterProtocol
extension SignupPresenter: SignupPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    func signUP(with parameters: signupRequest) {
        interactor?.signup(with: parameters)
    }
}

// MARK: Conform to SignupInteractorOutput
extension SignupPresenter: SignupInteractorOutput {
    
    func succeedSignup(signupEntity: SignupEntity) {
        router?.showVerificationPage(with: signupEntity.data?.token ?? "")
    }
    
    func didFailedSignup(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
    
    func showLoading() {
        view?.showLoadingIndicator()
    }
    
    func dismissLoading() {
        view?.showFailureIndicator()
    }
    
}
