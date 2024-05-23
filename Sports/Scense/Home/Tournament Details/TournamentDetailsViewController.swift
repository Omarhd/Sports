//
//  TournamentDetailsViewController.swift
//  Sports
//
//  Created by ios Dev on 13/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class TournamentDetailsViewController: UIViewController {
    // MARK: Outlets
    //    @IBOutlet private weak var testLabel: UILabel!
    // MARK: Propertiesss
    var presenter: TournamentDetailsPresenterProtocol?
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension TournamentDetailsViewController: TournamentDetailsControllerProtocol {
}

