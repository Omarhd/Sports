//
//  SignInViewController.swift
//  Sports
//
//  Created by ios Dev on 06/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

class SignInViewController: UITableViewController {
    
    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var emailValidationView: UIView!
    @IBOutlet weak var passwordValidationView: UIView!
    
    // MARK: Properties
    var presenter: SignInPresenterProtocol?
    let messageHelper: SwiftMessagesHelper
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialiser
    init(messageHelper: SwiftMessagesHelper = .shared) {
        self.messageHelper = messageHelper
        super.init(nibName: nil, bundle: nil)
    }
            
    required init?(coder: NSCoder) {
        self.messageHelper = SwiftMessagesHelper.shared
        super.init(coder: coder)
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func emailTextFieldDidChange(_ textField: UITextField) {
        presenter?.emailDidChange(textField.text)
    }
    
    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        presenter?.passwordDidChange(textField.text)
    }
    
    @IBAction func signInAction(_ sender: Any) {
        guard let email = emailTextField.text, email.isNotEmpty, email.isValidEmail else { return }
        guard let password = passwordTextField.text, password.isNotEmpty, password.isValidPassword else { return }
        
        let parameters: SignInRequest = .init(email: email, password: password)
        presenter?.signIn(with: parameters)
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        presenter?.pushToSignup()
    }
}

extension SignInViewController: SignInControllerProtocol {
    
    func updateSignInButton(isEnabled: Bool) {
        signInButton.isEnabled = isEnabled
    }

    func showFailureAlert(with error: String) {
        messageHelper.showMessage(title: "Error".localized, body: error, theme: .error, presentationStyle: .top, duration: .forever)
        self.signInButton.isEnabled = true
        self.signUpButton.isEnabled = true
    }
    
    func showLoadingIndicator() {
        self.view.showLottieLoader(with: "LoadingSquare")
        self.signInButton.isEnabled = false
        self.signUpButton.isEnabled = false
    }
    
    func showFailureIndicator() {
        self.view.hideLottieLoader()
        self.signInButton.isEnabled = true
        self.signUpButton.isEnabled = true
    }
}
