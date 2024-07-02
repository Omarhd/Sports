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
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Properties
    var presenter: MatchH2HPresenterProtocol?
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
        tableView.registerCell(cell: MatchH2HSelectionTableViewCell.self)
        tableView.registerCell(cell: MatchH2HTableViewCell.self)
    }
}

extension MatchH2HViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = H2HSection(rawValue: section) else { return 0 }
        return presenter?.numberOfRowsInSection(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = H2HSection(rawValue: indexPath.section) else { return UITableViewCell() }

        switch section {
        case .selection:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchH2HSelectionTableViewCell.viewIdentifier(), for: indexPath) as? MatchH2HSelectionTableViewCell else { return UITableViewCell() }
            presenter?.configureH2HSelectionCell(for: cell, for: indexPath, delegate: self)

            return cell
            
        case .matches:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchH2HTableViewCell.viewIdentifier(), for: indexPath) as? MatchH2HTableViewCell else { return UITableViewCell() }
            presenter?.configureH2HVersesMatchCell(for: cell, for: indexPath)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = H2HSection(rawValue: indexPath.section) else { return 0 }
        return presenter?.heightForRowInSection(in: section) ?? 0
    }
}

extension MatchH2HViewController: MatchH2HControllerProtocol {
    
    func loadTableView() {
        tableView.setupTableView(viewController: self)
        loadTableAndCollection(tableView: tableView)
    }
    
    func setEmptyState() {
        setEmptyCase(imageName: "figure.basketball", title: "No Data", message: "Try again Later".localized, containerView: self.view)
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

extension MatchH2HViewController: MatchH2HSelectionTableViewCellProtocol {

    func didSelectOption(with index: TeamSelection) {
        presenter?.selectedOption = index
        self.tableView.reloadData()
    }
}
