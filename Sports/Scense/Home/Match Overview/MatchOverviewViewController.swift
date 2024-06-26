//
//  MatchOverviewViewController.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchOverviewViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Properties
    
    var presenter: MatchOverviewPresenterProtocol?
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        tableView.registerCell(cell: VenueTableViewCell.self)
        tableView.registerCell(cell: WeatherTableViewCell.self)
        tableView.registerCell(cell: TournamentTableViewCell.self)
    }
}

extension MatchOverviewViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = MatchOverviewSection(rawValue: section) else { return 0 }
        return presenter?.numberOfCells(in: section) ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = MatchOverviewSection(rawValue: indexPath.section) else { return 0 }
        return presenter?.heightForRowInSection(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = MatchOverviewSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .venue:
            let cell = tableView.dequeueReusableCell(withIdentifier: VenueTableViewCell.viewIdentifier(), for: indexPath) as! VenueTableViewCell
            presenter?.configureVenueCell(with: cell, for: indexPath)
            cell.backgroundColor = .red
            return cell
            
        case .weather:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.viewIdentifier(), for: indexPath) as! WeatherTableViewCell
            presenter?.configureWeatherCell(with: cell, for: indexPath)
            return cell
            
            
        case .tournament:
            let cell = tableView.dequeueReusableCell(withIdentifier: TournamentTableViewCell.viewIdentifier(), for: indexPath) as! TournamentTableViewCell
            presenter?.configureTournamentCell(with: cell, for: indexPath)
            return cell
        }
    }
}


extension MatchOverviewViewController: MatchOverviewControllerProtocol {
    
    func reloadSection() {
        tableView.setupTableView(viewController: self)
        loadTableAndCollection(tableView: tableView)
    }
    
}

