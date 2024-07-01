//
//  NewsDetailsConfigurator.swift
//  Sports
//
//  Created by ios Dev on 06/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct NewsDetailsInput { 
    var news: News
}

final class NewsDetailsConfigurator {
    
    // MARK: Configuration
    class func viewController(input: NewsDetailsInput) -> NewsDetailsViewController {
        let storyBoard = UIStoryboard.init(name: NewsStoryboard, bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: "NewsDetailsViewController") as? NewsDetailsViewController else { return NewsDetailsViewController() }
        let interactor = NewsDetailsInteractor()
        let router = NewsDetailsRouter(viewController: view)
        let presenter = NewsDetailsPresenter(view: view,
                                             interactor: interactor,
                                             router: router,
                                             news: input.news)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol NewsDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectTappedImage(image: UIImage)
}

// Presenter --> Controller
protocol NewsDetailsControllerProtocol: AnyObject {
    func configureNewsUI(with news: News)
    func showFailureAlert(with error: String)
}

// Presenter --> Interactor
protocol NewsDetailsPresenterInteractorProtocol: AnyObject {
    func fetchNewsDetails(newsID: Int)
}

// Interactor --> Presenter
protocol NewsDetailsInteractorOutput: AnyObject {
    func succeedReceivedNewsDetails(newsDetails: News)
    func didFailedLoadingNewsDetails(error: Error)
}
// Presenter --> Router
protocol NewsDetailsRouterProtocol: AnyObject {
    func popViewController()
    func showFullImage(image: UIImage)
}
