//
//  NewsConfigurator.swift
//  Sports
//
//  Created by ios Dev on 23/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct NewsInput { }

final class NewsConfigurator {
    
    // MARK: Configuration
    class func viewController(input: NewsInput) -> NewsViewController {
        let storyBoard = UIStoryboard.init(name: NewsStoryboard, bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: "NewsViewController") as? NewsViewController else { return NewsViewController() }
        let interactor = NewsInteractor()
        let router = NewsRouter(viewController: view)
        let presenter = NewsPresenter(view: view,
                                      interactor: interactor,
                                    router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol NewsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func fetchPaginationListNews()
    var numberOfSections: Int { get }
    func heightForRowInSection(in section: NewsSection) -> CGFloat
    func numberOfNews(in section: NewsSection) -> Int
    func configureHotNewsCell(with cell: HotNewsTableViewCell, for indexPath: IndexPath, delegate: HotNewsCellViewControllerProtocol)
    func configureListNewsCell(with cell: ListNewsTableViewCell, for indexPath: IndexPath)
    func didSelectNews(at indexPath: IndexPath)
}

// Presenter --> Controller
protocol NewsControllerProtocol: AnyObject {
    func setEmptyState()
    func showFailureAlert(with error: String)
    func reloadSection(_ section: NewsSection)
    func showLoadingIndicator()
    func showFailureIndicator()
}

// Presenter --> Interactor
protocol NewsPresenterInteractorProtocol: AnyObject {
    func fetchNews(parameters: NewsRequest)
    func fetchHotNews()
}

// Interactor --> Presenter
protocol NewsInteractorOutput: AnyObject {
    func succeedReceivedHotNews(newsData: NewsEntity)
    func succeedReceivedNews(newsData: NewsEntity)
    func didFailedLoadingHotNews(error: Error)
    func didFailedLoadingNews(error: Error)
    func showLoading()
    func dismissLoading()
}
// Presenter --> Router
protocol NewsRouterProtocol: AnyObject {
    func popViewController()
    func navigateToDetails(news: News)
}

protocol HotNewsCellCellProtocol: AnyObject {
    func configureCellUI(news: [News]?)
}

// Cell --> Protocol
protocol NewsCellCellProtocol: AnyObject {
    func configureCellUI(news: News?)
}

protocol HotNewsCellViewControllerProtocol: AnyObject {
    func didSelectNews(indexPath: IndexPath)
}
