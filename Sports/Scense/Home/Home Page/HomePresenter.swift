//
//  HomePresenter.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HomePresenter: NSObject {
    // MARK: - Properties
    private var view: HomeControllerProtocol?
    private var interactor: HomePresenterInteractorProtocol?
    private var router: HomeRouterProtocol?

    internal var numberOfSections: Int { return HomeSections.allCases.count }
    
    var stories: [HomeStoryEntity] = []
    var highlights: [HighlightsNews] = []
    var posts: [Post] = []
    
    // MARK: - Init
    init(view: HomeControllerProtocol?,
         interactor: HomePresenterInteractorProtocol?,
         router: HomeRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: Conform to HomePresenterProtocol
extension HomePresenter: HomePresenterProtocol {

    func viewDidLoad() {
        interactor?.fetchStories()
        interactor?.fetchHighlight()
        interactor?.fetchPosts()
    }
    
    func didSelectTappedImage(image: UIImage) {
        router?.showFullImage(image: image)
    }
    
    func didTappedStory(story: HomeStoryEntity, allStories: [HomeStoryEntity]) {
        router?.showFullStory(story: story, allStories: allStories)
    }
    
    func didSelectPost(for index: IndexPath) {
        router?.showPostDetails(with: posts[index.row])
    }
    
    func numberOfRowsInSection(in section: HomeSections) -> Int {
        switch section {
        case .stories: return stories.isEmpty ? 0 : 1
        case .highlightNews: return highlights.isEmpty ? 0 : 1
        case .posts: return posts.isEmpty ? 0 : posts.count
        }
    }
    
    func heightForRowInSection(in section: HomeSections) -> CGFloat? {
        switch section {
        case .stories: return stories.isEmpty ? 0 : 80.0
        case .highlightNews: return highlights.isEmpty ? 0 : 80.0
        case .posts: return posts.isEmpty ? 0 : 800.0
        }
    }
    
    func viewForHeaderInSection(in section: HomeSections, for sectionView: HighlightHeaderTableViewCell) {
        switch section {
        case .stories: return
        case .highlightNews: sectionView.configureCell(title: "Highlights", isSeeAllEnabled: false)
        case .posts: sectionView.configureCell(title: "Feeds", isSeeAllEnabled: true)
        }
    }
    
    func heightForHeaderInSection(in section: HomeSections) -> CGFloat? {
        switch section {
        case .stories: return 0
        case .highlightNews: return highlights.isEmpty ? 0 : 45.0
        case .posts: return posts.isEmpty ? 0 : 45.0
        }
    }
    
    func configureStoriesCell(for cell: StoriesTableViewCell, for index: IndexPath, delegate: StoriesCollectionCellViewControllerProtocol?) {
        let cellData = stories
        cell.delegate = delegate
        cell.configureCell(with: cellData)
    }
    
    func configureHighlightsCell(for cell: HighlightsTableViewCell, for index: IndexPath, delegate: HighlightsCellViewControllerProtocol?) {
        let cellData = highlights
        cell.delegate = delegate
        cell.configureCell(with: cellData)
    }
    
    func configurePostCell(for cell: PostsTableViewCell, for index: IndexPath, delegate: PostCellViewControllerProtocol?) {
        let cellData = posts[index.row]
        cell.delegate = delegate
        cell.configureCell(with: cellData)
    }
    
    func didSelectHighlight(for index: Int) {
        let highlight = self.highlights[index]
        highlight.detail == "#" ? (router?.openHighlightLink(highlightLink: highlight.headline ?? "")) : (router?.navigateToHighlightsDetails(highlight: highlight))
    }
}

// MARK: Conform to HomeInteractorOutput
extension HomePresenter: HomeInteractorOutput {
  
    func succeedReceivedStories(stories: [HomeStoryEntity]) {
        self.stories = stories
        stories.isEmpty ? view?.setEmptyState() : view?.loadTableView()
    }
    
    func succeedReceivedHighlights(highlights: HomeHighlightsEntity) {
        self.highlights = highlights.response?.news ?? []
        self.highlights.isEmpty ? view?.setEmptyState() : view?.loadTableView()
    }
    
    func succeedReceivedPosts(posts: HomeEntity) {
        self.posts = posts.post
        self.posts.isEmpty ? view?.setEmptyState() : view?.loadTableView()
    }
    
    func didFailedLoading(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
    
    func showLoading() {
        view?.showLoadingIndicator()
    }
    
    func dismissLoading() {
        view?.showFailureIndicator()
    }
}
