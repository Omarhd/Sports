//
//  SettingsViewController.swift
//  Sports
//
//  Created by ios Dev on 24/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    // MARK: Outlets
    //    @IBOutlet private weak var testLabel: UILabel!
    // MARK: Propertiesss
    var presenter: SettingsPresenterProtocol?
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension SettingsViewController: SettingsControllerProtocol {
}

