//
//  SignupPresenter.swift
//  Sports
//
//  Created by ios Dev on 04/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

final class SignupPresenter: NSObject {
    // MARK: - Properties
    private var view: SignupControllerProtocol?
    private var interactor: SignupPresenterInteractorProtocol?
    private var router: SignupRouterProtocol?

    // Combine properties
    private var nameTextField = PassthroughSubject<String?, Never>()
    private var emailTextField = PassthroughSubject<String?, Never>()
    private var passwordTextField = PassthroughSubject<String?, Never>()
    private var confirmPasswordTextField = PassthroughSubject<String?, Never>()

    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(view: SignupControllerProtocol?,
         interactor: SignupPresenterInteractorProtocol?,
         router: SignupRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
        super.init()
    }
}
// MARK: Conform to SignupPresenterProtocol
extension SignupPresenter: SignupPresenterProtocol {
    
    func viewDidLoad() {
        setupBindings()
    }
    
    func signUP(with parameters: signupRequest) {
        interactor?.signup(with: parameters)
    }
    
    func nameDidChange(_ name: String?) {
        nameTextField.send(name)
    }
    
    func emailDidChange(_ email: String?) {
        emailTextField.send(email)
    }

    func passwordDidChange(_ password: String?) {
        passwordTextField.send(password)
    }
    
    func confirmPasswordDidChange(_ confirmPassword: String?) {
        confirmPasswordTextField.send(confirmPassword)
    }
    
    func setupBindings() {
        Publishers.CombineLatest4(nameTextField, emailTextField, passwordTextField, confirmPasswordTextField)
            .map { [weak self] name, email, password, confirmPassword in
                guard let self = self else { return false }
                return self.isValidName(name) &&
                       self.isValidEmail(email) &&
                       self.isValidPassword(password) &&
                       self.isValidConfirmPassword(password, confirmPassword)
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] isValid in
                self?.view?.updateSignUpButton(isEnabled: isValid)
            }
            .store(in: &cancellables)
    }
    
    func isValidName(_ name: String?) -> Bool {
        guard let name = name, !name.isEmpty else { return false }
        return name.count >= 2
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
    
    func isValidConfirmPassword(_ password: String?, _ confirmPassword: String?) -> Bool {
        return confirmPassword == password
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
