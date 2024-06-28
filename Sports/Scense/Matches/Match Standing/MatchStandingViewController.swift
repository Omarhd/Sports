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
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Properties
    var presenter: MatchStandingPresenterProtocol?
    let messageHelper: SwiftMessagesHelper

    // MARK: - Initialiser
    init(messageHelper: SwiftMessagesHelper = .shared) {
        self.messageHelper = messageHelper
        super.init(nibName: nil, bundle: nil)
    }
            
    required init?(coder: NSCoder) {
        self.messageHelper = SwiftMessagesHelper.shared
        super.init(coder: coder)
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        tableView.registerCell(cell: SeasonStandingHeaderTableViewCell.self)
        tableView.registerCell(cell: SeasonSelectionTableViewCell.self)
        tableView.registerCell(cell: SeasonTeamTableViewCell.self)
    }
}

extension MatchStandingViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: SeasonStandingHeaderTableViewCell.viewIdentifier()) as? SeasonStandingHeaderTableViewCell else { return UITableViewCell() }
        guard let section = SeasonSection(rawValue: section) else { return UIView() }
        presenter?.viewForHeaderInSection(in: section, with: header, and: presenter?.selectedOption ?? .short)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = SeasonSection(rawValue: section) else { return 0 }
        return presenter?.heighForHeaderInSection(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SeasonSection(rawValue: section) else { return 0 }
        return presenter?.numberOfRowsInSection(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SeasonSection(rawValue: indexPath.section) else { return UITableViewCell() }

        switch section {
        case .selection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeasonSelectionTableViewCell.viewIdentifier(), for: indexPath) as? SeasonSelectionTableViewCell else { return UITableViewCell() }
            presenter?.configureSeasonSelectionCell(for: cell, for: indexPath, delegate: self)

            return cell
            
        case .teams:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeasonTeamTableViewCell.viewIdentifier(), for: indexPath) as? SeasonTeamTableViewCell else { return UITableViewCell() }
            presenter?.configureSeasonTeamCell(for: cell, for: indexPath, with: presenter?.selectedOption ?? .short)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = SeasonSection(rawValue: indexPath.section) else { return 0 }
        return presenter?.heightForRowInSection(in: section) ?? 0
    }
}

extension MatchStandingViewController: MatchStandingControllerProtocol {
    
    func loadTableView() {
        tableView.setupTableView(viewController: self)
        loadTableAndCollection(tableView: tableView)
    }
    
    func setEmptyState() {
        setEmptyCase(imageName: "figure.soccer", title: "No Data", message: "Try again Later".localized, containerView: self.view)
    }
    
    func showFailureAlert(with error: String) {
        messageHelper.showMessage(title: "\(error)", body: "Error While Fetching Data".localized, theme: .error, presentationStyle: .top, duration: .forever)
        setEmptyCase(imageName: "", title: "No Data".localized, message: "Try again Later".localized, containerView: self.view)
    }
    
    func showLoadingIndicator() {
        self.view.showLottieLoader(with: "LoadingBasket")
    }
    
    func showFailureIndicator() {
        self.view.hideLottieLoader()
    }
}

extension MatchStandingViewController: SeasonSelectionTableViewCellProtocol {

    func didSelectOption(with index: SeasonSelection) {
        presenter?.selectedOption = index
        self.tableView.reloadData()
    }
}
