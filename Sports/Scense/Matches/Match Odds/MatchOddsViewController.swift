//
//  MatchOddsViewController.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MatchOddsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Properties
    var presenter: MatchOddsPresenterProtocol?
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
        tableView.registerCell(cell: MatchOddsSelectionTableViewCell.self)
        tableView.registerCell(cell: MatchOddsTableViewCell.self)
    }
}

extension MatchOddsViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = OddsSection(rawValue: section) else { return 0 }
        return presenter?.numberOfRowsInSection(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = OddsSection(rawValue: indexPath.section) else { return UITableViewCell() }

        switch section {
        case .selection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchOddsSelectionTableViewCell.viewIdentifier(), for: indexPath) as? MatchOddsSelectionTableViewCell else { return UITableViewCell() }
            presenter?.configureOddsSelectionCell(for: cell, for: indexPath, delegate: self)

            return cell
            
        case .odds:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchOddsTableViewCell.viewIdentifier(), for: indexPath) as? MatchOddsTableViewCell else { return UITableViewCell() }
            presenter?.configureOddsMatchCell(for: cell, for: indexPath)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = OddsSection(rawValue: indexPath.section) else { return 0 }
        return presenter?.heightForRowInSection(in: section) ?? 0
    }
}

extension MatchOddsViewController: MatchOddsControllerProtocol {
    
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
        self.view.showFailureLottieLoader()
    }
    
    func showLoadingIndicator() {
        self.view.showLottieLoader(with: "LoadingBasket")
    }
    
    func showFailureIndicator() {
        self.view.hideLottieLoader()
    }
}

extension MatchOddsViewController: MatchOddsSelectionTableViewCellProtocol {

    func didSelectOption(with index: OddsSelection) {
        presenter?.selectedOption = index
        self.tableView.reloadData()
    }
}
