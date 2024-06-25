//
//  LiveViewController.swift
//  Sports
//
//  Created by ios Dev on 20/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LiveViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var presenter: LivePresenterProtocol?
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
        tableView.registerCell(cell: TournamentHeaderTableViewCell.self)
        tableView.registerCell(cell: MatchTableViewCell.self)
//        tableView.showGradientSkeleton()
//        tableView.startSkeletonAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableHero()
    }
}

extension LiveViewController: LiveControllerProtocol {
    
    func loadTableView() {
        tableView.setupTableView(viewController: self)
        loadTableAndCollection(tableView: tableView)
    }
    
    func setEmptyState() {
        setEmptyCase(imageName: "figure.soccer", title: "No Data", message: "Try again Later".localized, containerView: self.view)
    }
    
    func showFailureAlert(with error: String) {
        messageHelper.showMessage(title: "\(error)", body: "Error While Fetching Data".localized, theme: .error, presentationStyle: .top, duration: .forever)
        setEmptyCase(imageName: "figure.soccer", title: "No Data".localized, message: "Try again Later".localized, containerView: self.view)
        self.view.showFailureLottieLoader()
    }
    
    func showLoadingIndicator() {
        self.view.showLottieLoader(with: "LoadingSquare")
    }
    
    func showFailureIndicator() {
        self.view.hideLottieLoader()
    }
    
}

