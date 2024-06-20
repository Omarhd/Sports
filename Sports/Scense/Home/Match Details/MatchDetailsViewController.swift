//
//  MatchDetailsViewController.swift
//  Sports
//
//  Created by ios Dev on 19/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchDetailsViewController: UIViewController {

    // MARK: Outlets

    // MARK: Properties
    var presenter: MatchDetailsPresenterProtocol?
    
    // MARK: - Init

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension MatchDetailsViewController: MatchDetailsControllerProtocol {
}

