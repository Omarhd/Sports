//
//  DetailsPagesConfigurator.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct DetailsPagesInput { 
    let match: Match
    var pageControllerDelegate: PageControllerViewDelegate
}

final class DetailsPagesConfigurator {
    
    // MARK: Configuration
    class func viewController(input: DetailsPagesInput) -> DetailsPagesViewController {
        let storyBoard = UIStoryboard.init(name: MatchesStoryboard, bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: "DetailsPagesViewController") as? DetailsPagesViewController else { return DetailsPagesViewController() }
        let interactor = DetailsPagesInteractor()
        let router = DetailsPagesRouter(viewController: view)
        let presenter = DetailsPagesPresenter(view: view,
                                              interactor: interactor,
                                              router: router,
                                              pageControllerDelegate: input.pageControllerDelegate,
                                              match: input.match)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol DetailsPagesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func scrollToPage(with index: Int, for pageViewController: UIPageViewController)
}

// Presenter --> Controller
protocol DetailsPagesControllerProtocol: AnyObject {
    func setChilds(viewController: [UIViewController])
}

// Presenter --> Interactor
protocol DetailsPagesPresenterInteractorProtocol: AnyObject {
    func fetchPages(with match: Match)
}

// Interactor --> Presenter
protocol DetailsPagesInteractorOutput: AnyObject {
    func didFetchPages(_ pages: [UIViewController])
}
// Presenter --> Router
protocol DetailsPagesRouterProtocol: AnyObject {
    func popViewController()
}

// PageController -> MatchDetailsPresenter
protocol PageControllerViewDelegate: AnyObject {
    func updateCollectionIndex(with index: Int)
}
