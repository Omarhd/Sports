//
//  NewsViewController.swift
//  Sports
//
//  Created by ios Dev on 23/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Properties
    var presenter: NewsPresenterProtocol?
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
        tableView.registerCell(cell: HotNewsSectionHeaderTableViewCell.self)
        tableView.registerCell(cell: HotNewsTableViewCell.self)
        tableView.registerCell(cell: ListNewsSectionHeaderTableViewCell.self)
        tableView.registerCell(cell: ListNewsTableViewCell.self)
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

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = NewsSection(rawValue: section) else { return 0 }
        return presenter?.numberOfNews(in: section) ?? 0

    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = NewsSection(rawValue: indexPath.section) else { return 0 }
        return presenter?.heightForRowInSection(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let hotNewsHeader = tableView.dequeueReusableCell(withIdentifier: HotNewsSectionHeaderTableViewCell.viewIdentifier()) as? HotNewsSectionHeaderTableViewCell else { return UITableViewCell() }
        return hotNewsHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = NewsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .hotNews:
            let cell = tableView.dequeueReusableCell(withIdentifier: HotNewsTableViewCell.viewIdentifier(), for: indexPath) as! HotNewsTableViewCell
            presenter?.configureHotNewsCell(with: cell, for: indexPath)
            cell.backgroundColor = .red
            return cell
            
        case .listNews:
            let cell = tableView.dequeueReusableCell(withIdentifier: ListNewsTableViewCell.viewIdentifier(), for: indexPath) as! ListNewsTableViewCell
            presenter?.configureListNewsCell(with: cell, for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didSelectNews(at: indexPath)
    }
}


extension NewsViewController: NewsControllerProtocol {
    
    func reloadSection(_ section: NewsSection) {
        tableView.setupTableView(viewController: self)
        loadTableAndCollection(tableView: tableView)
    }
    
    func setEmptyState() {
        setEmptyCase(imageName: "", title: "No Data".localized, message: "Try again Later".localized, containerView: self.view)
    }
    
    func showFailureAlert(with error: String) {
        messageHelper.showMessage(title: "\(error)", body: "Error While Fetching Data".localized, theme: .error, presentationStyle: .top, duration: .seconds(seconds: 3.0))
        setEmptyCase(imageName: "", title: "No Data".localized, message: "Try again Later".localized, containerView: self.view)
    }
    
}

