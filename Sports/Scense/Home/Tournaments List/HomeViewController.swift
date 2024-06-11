//
//  HomeViewController.swift
//  Sports
//
//  Created by ios Dev on 09/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Hero
import SkeletonView
import Combine

class HomeViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Properties
    var presenter: HomePresenterProtocol?
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
        tableView.registerCell(cell: TournamentTableViewCell.self)
        tableView.showGradientSkeleton()
        tableView.startSkeletonAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableHero()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        disableHero()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfTournament ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tournamentCell = tableView.dequeueReusableCell(withIdentifier: TournamentTableViewCell.viewIdentifier(), for: indexPath) as? TournamentTableViewCell else { return UITableViewCell() }
        self.presenter?.configureCell(with: tournamentCell, for: indexPath.row)
       
        return tournamentCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didSelect(for: indexPath.row)
    }
}

extension HomeViewController: HomeControllerProtocol {
    
    func loadTableView() {
        tableView.setupTableView(viewController: self)
        loadTableAndCollection(tableView: tableView)
    }
    
    func setEmptyState() {
        setEmptyCase(imageName: "figure.soccer", title: "No Data", message: "Try again Later".localized, containerView: self.view)
    }
    
    func showFailureAlert(with error: String) {
        messageHelper.showMessage(title: "\(error)", body: "Error While Fetching Data".localized, theme: .error, presentationStyle: .top, duration: .forever)
        setEmptyCase(imageName: "figure.soccer", title: "No Data", message: "Try again Later".localized, containerView: self.view)
    }
    
}
