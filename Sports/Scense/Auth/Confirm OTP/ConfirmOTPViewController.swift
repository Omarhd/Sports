//
//  ConfirmOTPViewController.swift
//  Sports
//
//  Created by ios Dev on 04/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ConfirmOTPViewController: UITableViewController {
    
    // MARK: Outlets
    @IBOutlet weak var confirmOTPBarButton: UIBarButtonItem!
    @IBOutlet weak var confirmOTPTextField: UITextField!
    @IBOutlet weak var resendOTPButton: UIButton!
    
    // MARK: Properties
    var presenter: ConfirmOTPPresenterProtocol?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        isModalInPresentation = true
        presenter?.viewDidLoad()
    }
    
    @IBAction func confirmOTPAction(_ sender: Any) {
    }
    
    @IBAction func resentOTPAction(_ sender: Any) {
    }
}

extension ConfirmOTPViewController: ConfirmOTPControllerProtocol {
}

