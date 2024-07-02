//
//  MomentsViewController.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MomentsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var presenter: MomentsPresenterProtocol?
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
        tableView.registerCell(cell: HighlightHeaderTableViewCell.self)
        tableView.registerCell(cell: FollowingMomentTableViewCell.self)
        tableView.registerCell(cell: HighlightMomentTableViewCell.self)
    }
}

extension MomentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: HighlightHeaderTableViewCell.viewIdentifier()) as? HighlightHeaderTableViewCell else { return UITableViewCell() }
        guard let section = MomentsSections(rawValue: section) else { return UIView() }
        presenter?.viewForHeaderInSection(in: section, for: header)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = MomentsSections(rawValue: section) else { return 0 }
        return presenter?.heightForHeaderInSection(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = MomentsSections(rawValue: section) else { return 0 }
        return presenter?.numberOfRowsInSection(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = MomentsSections(rawValue: indexPath.section) else { return UITableViewCell() }

        switch section {
        case .following:
            guard let followingCell = tableView.dequeueReusableCell(withIdentifier: FollowingMomentTableViewCell.viewIdentifier(), for: indexPath) as? FollowingMomentTableViewCell else { return UITableViewCell() }
            presenter?.configureFollowingCell(for: followingCell, delegate: self)
            return followingCell
            
        case .highlight:
            guard let highlightCell = tableView.dequeueReusableCell(withIdentifier: HighlightMomentTableViewCell.viewIdentifier(), for: indexPath) as? HighlightMomentTableViewCell else { return UITableViewCell() }
            presenter?.configureHighlightsCell(for: highlightCell, delegate: self)
            return highlightCell
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let section = MomentsSections(rawValue: indexPath.section) else { return 0 }
//        return presenter?.heightForRowInSection(in: section) ?? 0
//    }
}

extension MomentsViewController: MomentsCollectionCellViewControllerProtocol {
    
    func didTappedMoment(with moment: MomentsEntity, allMoments: [MomentsEntity]) {
        presenter?.didTappedMoment(with: moment, allMoments: allMoments)
    }
    
   
}

extension MomentsViewController: MomentsControllerProtocol {
    
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
    }
    
    func showLoadingIndicator() {
        self.view.showLottieLoader(with: "LoadingBasket")
    }
    
    func showFailureIndicator() {
        self.view.hideLottieLoader()
    }
    
}

