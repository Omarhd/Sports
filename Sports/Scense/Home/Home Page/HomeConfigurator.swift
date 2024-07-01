//
//  HomeConfigurator.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct HomeInput { }

final class HomeConfigurator {
    
    // MARK: Configuration
    class func viewController(input: HomeInput) -> HomeViewController {
        let storyBoard = UIStoryboard.init(name: HomeStoryboard, bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return HomeViewController() }
        let interactor = HomeInteractor()
        let router = HomeRouter(viewController: view)
        let presenter = HomePresenter(view: view,
                                                          interactor: interactor,
                                                          router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectTappedImage(image: UIImage)
    func didTappedStory(story: HomeStoryEntity, allStories: [HomeStoryEntity])
    func didSelectHighlight(for index: Int)
    func didSelectPost(for index: IndexPath)
    
    func numberOfRowsInSection(in section: HomeSections) -> Int
    func heightForRowInSection(in section: HomeSections) -> CGFloat?

    func configureStoriesCell(for cell: StoriesTableViewCell, for index: IndexPath, delegate: StoriesCollectionCellViewControllerProtocol?)
    func configureHighlightsCell(for cell: HighlightsTableViewCell, for index: IndexPath, delegate: HighlightsCellViewControllerProtocol?)
    func configurePostCell(for cell: PostsTableViewCell, for index: IndexPath, delegate: PostCellViewControllerProtocol?)

    func viewForHeaderInSection(in section: HomeSections, for sectionView: HighlightHeaderTableViewCell)
    func heightForHeaderInSection(in section: HomeSections) -> CGFloat?
    
    var numberOfSections: Int { get }
}

// Presenter --> Controller
protocol HomeControllerProtocol: AnyObject {
    func setEmptyState()
    func showFailureAlert(with error: String)
    func loadTableView()
    func showLoadingIndicator()
    func showFailureIndicator()
}

// Presenter --> Interactor
protocol HomePresenterInteractorProtocol: AnyObject {
    func fetchStories()
    func fetchHighlight()
    func fetchPosts()
}

// Interactor --> Presenter
protocol HomeInteractorOutput: AnyObject {
    func succeedReceivedStories(stories: [HomeStoryEntity])
    func succeedReceivedHighlights(highlights: HomeHighlightsEntity)
    func succeedReceivedPosts(posts: HomeEntity)
    func didFailedLoading(error: Error)
    func showLoading()
    func dismissLoading()
}
// Presenter --> Router
protocol HomeRouterProtocol: AnyObject {
    func popViewController()
    func showFullImage(image: UIImage)
    func showFullStory(story: HomeStoryEntity, allStories: [HomeStoryEntity])
    func showPostDetails(with post: Post)
    func navigateToHighlightsDetails(highlight: HighlightsNews)
    func openHighlightLink(highlightLink: String)
}

protocol StoriesCellProtocol: AnyObject {
    func configureCell(with stories: [HomeStoryEntity])
}

protocol HighlightsCellProtocol: AnyObject {
    func configureCell(with highlight: [HighlightsNews])
}

protocol PostCellProtocol: AnyObject {
    func configureCell(with post: Post?)
}

protocol PostCellViewControllerProtocol: AnyObject {
    func didTappedImage(image: UIImage)
}

protocol highlightCollectionCellProtocol: AnyObject {
    func configureCell(with highlight: HighlightsNews)
}

protocol StoriesCollectionCellProtocol: AnyObject {
    func configureCell(with story: HomeStoryEntity)
}

protocol StoriesCollectionCellViewControllerProtocol: AnyObject {
    func didTappedStory(with story: HomeStoryEntity, allStories: [HomeStoryEntity])
}

protocol HighlightsCellViewControllerProtocol: AnyObject {
    func didSelectHighlight(for index: Int)
}

protocol HighlightsHeaderViewCellProtocols: AnyObject {
    func configureCell(title: String, isSeeAllEnabled: Bool)
}
