//
//  TextFiled.swift
//  Sports
//
//  Created by ios Dev on 04/07/2024.
//

import UIKit

extension UITextField {
    
    enum VerificationType {
        case name
        case email
        case password
        case confirmPassword
    }
    
    func setupValidation(type: VerificationType, validationView: UIView) {
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        validationView.layer.borderWidth = 1.0
        validationView.layer.cornerRadius = 5.0
        validationView.layer.masksToBounds = true
        
        self.validationType = type
        validate(type: type, validationView: validationView)
    }
    
    @objc private func textFieldDidChange() {
        guard let validationView = superview else { return }
        
        if let type = validationType {
            validate(type: type, validationView: validationView)
        }
    }
    
    private func validate(type: VerificationType, validationView: UIView) {
        switch type {
        case .name:
            if isValidName() {
                validationView.layer.borderColor = UIColor.green.cgColor
            } else {
                validationView.layer.borderColor = UIColor.red.cgColor
            }
        case .email:
            if isValidEmail() {
                validationView.layer.borderColor = UIColor.green.cgColor
            } else {
                validationView.layer.borderColor = UIColor.red.cgColor
            }
        case .password:
            if isValidPassword() {
                validationView.layer.borderColor = UIColor.green.cgColor
            } else {
                validationView.layer.borderColor = UIColor.red.cgColor
            }
        case .confirmPassword:
            if isValidConfirmPassword() {
                validationView.layer.borderColor = UIColor.green.cgColor
            } else {
                validationView.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    private func isValidName() -> Bool {
        guard let text = self.text else { return false }
        return !text.isEmpty
    }
    
    private func isValidEmail() -> Bool {
        guard let text = self.text else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: text)
    }
    
    private func isValidPassword() -> Bool {
        guard let text = self.text else { return false }
        return text.count >= 8
    }
    
    private func isValidConfirmPassword() -> Bool {
        guard let text = self.text, let passwordField = superview?.viewWithTag(tag - 1) as? UITextField else { return false }
        return text == passwordField.text
    }
    
    private var validationType: VerificationType? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.validationType) as? VerificationType
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.validationType, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private struct AssociatedKeys {
        static var validationType = "validationType"
    }
}
