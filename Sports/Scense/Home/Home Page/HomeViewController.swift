//
//  HomeViewController.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class HomeViewController: CustomViewController {
   
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
   
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
        tableView.registerCell(cell: StoriesTableViewCell.self)
        tableView.registerCell(cell: HighlightHeaderTableViewCell.self)
        tableView.registerCell(cell: HighlightsTableViewCell.self)
        tableView.registerCell(cell: PostsTableViewCell.self)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: HighlightHeaderTableViewCell.viewIdentifier()) as? HighlightHeaderTableViewCell else { return UITableViewCell() }
        guard let section = HomeSections(rawValue: section) else { return UIView() }
        presenter?.viewForHeaderInSection(in: section, for: header)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = HomeSections(rawValue: section) else { return 0 }
        return presenter?.heightForHeaderInSection(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = HomeSections(rawValue: section) else { return 0 }
        return presenter?.numberOfRowsInSection(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeSections(rawValue: indexPath.section) else { return UITableViewCell() }
        
        
        switch section {
        case .stories:
            guard let storiesCell = tableView.dequeueReusableCell(withIdentifier: StoriesTableViewCell.viewIdentifier(), for: indexPath) as? StoriesTableViewCell else { return UITableViewCell() }
            presenter?.configureStoriesCell(for: storiesCell, for: indexPath, delegate: self)
            
            return storiesCell
            
        case .highlightNews:
            guard let highlightNewsCell = tableView.dequeueReusableCell(withIdentifier: HighlightsTableViewCell.viewIdentifier(), for: indexPath) as? HighlightsTableViewCell else { return UITableViewCell() }
            presenter?.configureHighlightsCell(for: highlightNewsCell, for: indexPath, delegate: self)
            
            return highlightNewsCell
            
        case .posts:
            guard let postsCell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.viewIdentifier(), for: indexPath) as? PostsTableViewCell else { return UITableViewCell() }
            presenter?.configurePostCell(for: postsCell, for: indexPath, delegate: self)
            
            return postsCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectPost(for: indexPath)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let section = HomeSections(rawValue: indexPath.section) else { return 0 }
//        return presenter?.heightForRowInSection(in: section) ?? 0
//    }
    
}

extension HomeViewController: HighlightsCellViewControllerProtocol {
    
    func didSelectHighlight(for index: Int) {
        presenter?.didSelectHighlight(for: index)
    }
}

extension HomeViewController: PostCellViewControllerProtocol {
    
    func didTappedImage(image: UIImage) {
        presenter?.didSelectTappedImage(image: image)
    }
}

extension HomeViewController: StoriesCollectionCellViewControllerProtocol {
    func didTappedStory(with story: HomeStoryEntity, allStories: [HomeStoryEntity]) {
        presenter?.didTappedStory(story: story, allStories: allStories)
    }
}

extension HomeViewController: HomeControllerProtocol {
    
    func loadTableView() {
        tableView.setupTableView(viewController: self)
        loadTableAndCollection(tableView: tableView)
    }
    
    func setEmptyState() {
        setEmptyCase(imageName: "figure.basketball", title: "No Data", message: "Try again Later".localized, containerView: self.view)
    }
    
    func showFailureAlert(with error: String) {
        messageHelper.showMessage(title: "\(error)", body: "Error While Fetching Data".localized, theme: .error, presentationStyle: .top, duration: .forever)
    }
    
    func showLoadingIndicator() {
        self.view.showLottieLoader(with: "LoadingBasket")
    }
    
    func showFailureIndicator() {
        self.view.hideLottieLoader()
    }
    
}

