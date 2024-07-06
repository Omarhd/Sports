//
//  HomeViewController.swift
//  Sports
//
//  Created by ios Dev on 09/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Hero

class MatchesViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var todayButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var liveSwitcher: UISwitch!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    
    // MARK: Properties
    var presenter: MatchesPresenterProtocol?
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
        collectionView.registerCell(cell: DateFilterCollectionViewCell.self)
        tableView.registerCell(cell: TournamentHeaderTableViewCell.self)
        tableView.registerCell(cell: MatchTableViewCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableHero()
    }
    
    @IBAction func liveSwitcherAction(_ sender: Any) {
        liveSwitcher.isOn ? (collectionView.isHidden = true) : (collectionView.isHidden = false)
        liveSwitcher.isOn ? (isToday()) : (itsNotToday())
        liveSwitcher.isOn ? (presenter?.fetchMatches(with: .live)) : (presenter?.fetchMatches(with: .dated))
    }
    
    @IBAction func todayAction(_ sender: Any) {
        presenter?.setToday(for: 6)
    }
    
    @IBAction func userAction(_ sender: Any) {
        presenter?.userDidPressed()
    }
    
}

extension MatchesViewController: MatchesControllerProtocol {
    
    func highlightSelectedDate(for indexPath: IndexPath) {
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    func loadTableView() {
        collectionView.setupCollectionView(viewController: self)
        tableView.setupTableView(viewController: self)
        loadTableAndCollection(tableView: tableView)
    }
    
    func setEmptyState() {
        setEmptyCase(imageName: "figure.basketball", title: "No Data", message: "Try again Later".localized, containerView: contentView)
    }
    
    func showFailureAlert(with error: String) {
        messageHelper.showMessage(title: "\(error)", body: "Error While Fetching Data".localized, theme: .error, presentationStyle: .top, duration: .forever)
        setEmptyCase(imageName: "", title: "No Data".localized, message: "Try again Later".localized, containerView: contentView)
        self.view.showFailureLottieLoader()
    }
    
    func showLoadingIndicator() {
        self.view.showLottieLoader(with: "LoadingBasket")
    }
    
    func showFailureIndicator() {
        self.view.hideLottieLoader()
    }
    
    func isToday() {
        UIView.animate(withDuration: 0.5) {
            self.todayButtonConstraint.constant = -90.0
            self.view.layoutIfNeeded()
        }
    }
    
    func itsNotToday() {
        UIView.animate(withDuration: 0.5) {
            self.todayButtonConstraint.constant = 90.0
            self.view.layoutIfNeeded()
        }
    }
}
