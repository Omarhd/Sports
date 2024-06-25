//
//  MatchStandingViewController.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchStandingViewController: UIViewController {
    // MARK: Outlets
    //    @IBOutlet private weak var testLabel: UILabel!
    // MARK: Propertiesss
    var presenter: MatchStandingPresenterProtocol?
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension MatchStandingViewController: MatchStandingControllerProtocol {
}

