//
//  SignupViewController.swift
//  Sports
//
//  Created by ios Dev on 04/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SignupViewController: UITableViewController {
    
    // MARK: Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpBarButton: UIButton!
    
    @IBOutlet weak var nameValidationView: UIView!
    @IBOutlet weak var emailValidationView: UIView!
    @IBOutlet weak var passwordValidationView: UIView!
    @IBOutlet weak var confirmPasswordValidationView: UIView!
    // MARK: Properties
    var presenter: SignupPresenterProtocol?
    let messageHelper: SwiftMessagesHelper
    
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
        
        nameTextField.setupValidation(type: .name, validationView: nameValidationView)
        emailTextField.setupValidation(type: .email, validationView: emailValidationView)
        passwordTextField.setupValidation(type: .password, validationView: passwordValidationView)
        confirmPasswordTextField.setupValidation(type: .confirmPassword, validationView: confirmPasswordValidationView)

    }
    
    @IBAction func signUpAction(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else { return }
        guard let email = emailTextField.text, !email.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else { return }

        let parameters: signupRequest = .init(name: name,
                                              email: email,
                                              password: password,
                                              confirmPassword: confirmPassword)
        presenter?.signUP(with: parameters)
    }
    
}

extension SignupViewController: SignupControllerProtocol {
    
    func showFailureAlert(with error: String) {
        messageHelper.showMessage(title: "Error".localized, body: error, theme: .error, presentationStyle: .top, duration: .forever)
    }
    
    func showLoadingIndicator() {
        self.view.showLottieLoader(with: "LoadingSquare")
    }
    
    func showFailureIndicator() {
        self.view.hideLottieLoader()
    }
    
}

