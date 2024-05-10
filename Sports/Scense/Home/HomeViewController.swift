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
    @IBOutlet private weak var homeTableView: UITableView!

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
        let nib = UINib(nibName: TournamentTableViewCell.viewIdentifier(), bundle: nil)
        homeTableView.register(nib, forCellReuseIdentifier: TournamentTableViewCell.viewIdentifier())
        homeTableView.showGradientSkeleton()
        homeTableView.startSkeletonAnimation()
        homeTableView.hideSkeleton(reloadDataAfter: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableHero()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disableHero()
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let homeCell = homeTableView.dequeueReusableCell(withIdentifier: TournamentTableViewCell.viewIdentifier(), for: indexPath) as? TournamentTableViewCell else { return TournamentTableViewCell() }
        
        return homeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailsViewController = MatchDetailsViewController()
//        detailsViewController.view.backgroundColor = .blue
//        showHero(detailsViewController, navigationAnimationType: .zoom)
    }
    
}

extension HomeViewController: HomeControllerProtocol {
   
    func setEmptyState() {
        
    }
    
    func showFailureAlert(with error: String) {
        messageHelper.showMessage(title: "\(error)", body: "Error While Fetching Data".localized(), theme: .error, presentationStyle: .top, duration: .seconds(seconds: 3.0))
    }
   
    func loadTableView() {
        homeTableView.reloadData()
    }
    
}
