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
    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties
    
    var presenter: MatchStatsPresenterProtocol?
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        tableView.registerCell(cell: StatTableViewCell.self)
    }
}

extension MatchStatsViewController: MatchStatsControllerProtocol {

    func reloadTableView() {
        tableView.setupTableView(viewController: self)
        tableView.reloadData()
    }
    
    func setEmptyView() {
        setEmptyCase(imageName: "figure.soccer", title: "No Data", message: "Try again Later".localized, containerView: self.view)
    }
}

extension MatchStatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let statCell = tableView.dequeueReusableCell(withIdentifier: StatTableViewCell.viewIdentifier(), for: indexPath) as? StatTableViewCell else { return UITableViewCell() }
        presenter?.configureStatCell(for: statCell, for: indexPath.row)
        return statCell
    }
    
}

