//
//  SignInPresenter.swift
//  Sports
//
//  Created by ios Dev on 06/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

final class SignInPresenter: NSObject {
    // MARK: - Properties
    private var view: SignInControllerProtocol?
    private var interactor: SignInPresenterInteractorProtocol?
    private var router: SignInRouterProtocol?

    // Combine properties
    private var emailTextField = PassthroughSubject<String?, Never>()
    private var passwordTextField = PassthroughSubject<String?, Never>()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    init(view: SignInControllerProtocol?,
         interactor: SignInPresenterInteractorProtocol?,
         router: SignInRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        super.init()
    }
}
// MARK: Conform to SignInPresenterProtocol
extension SignInPresenter: SignInPresenterProtocol {
    
    func viewDidLoad() {
        setupBindings()
    }

    func signIn(with parameters: SignInRequest) {
        interactor?.signup(with: parameters)
    }
    
    func pushToSignup() {
        router?.showSignupViewController()
    }
    
    func emailDidChange(_ email: String?) {
        emailTextField.send(email)
    }

    func passwordDidChange(_ password: String?) {
        passwordTextField.send(password)
    }
    
    func setupBindings() {
        Publishers.CombineLatest(emailTextField, passwordTextField)
            .map { [weak self] email, password in
                guard let self = self else { return false }
                return self.isValidEmail(email) && self.isValidPassword(password)
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] isValid in
                self?.view?.updateSignInButton(isEnabled: isValid)
            }
            .store(in: &cancellables)
    }
    
    func isValidEmail(_ email: String?) -> Bool {
        guard let email = email, !email.isEmpty else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }

    func isValidPassword(_ password: String?) -> Bool {
        guard let password = password, !password.isEmpty else { return false }
        return password.count >= 8
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
