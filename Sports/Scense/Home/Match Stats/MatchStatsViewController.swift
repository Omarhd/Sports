//
//  MatchStatsViewController.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchStatsViewController: UIViewController {
    // MARK: Outlets
    //    @IBOutlet private weak var testLabel: UILabel!
    // MARK: Propertiesss
    var presenter: MatchStatsPresenterProtocol?
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension MatchStatsViewController: MatchStatsControllerProtocol {
}

