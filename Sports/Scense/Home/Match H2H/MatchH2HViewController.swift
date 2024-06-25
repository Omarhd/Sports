//
//  MatchH2HViewController.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchH2HViewController: UIViewController {
    // MARK: Outlets
    //    @IBOutlet private weak var testLabel: UILabel!
    // MARK: Propertiesss
    var presenter: MatchH2HPresenterProtocol?
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension MatchH2HViewController: MatchH2HControllerProtocol {
}

