//
//  HighlightsDetailsConfigurator.swift
//  Sports
//
//  Created by ios Dev on 01/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct HighlightsDetailsInput { 
    let highlight: HighlightsNews
}

final class HighlightsDetailsConfigurator {
    
    // MARK: Configuration
    class func viewController(input: HighlightsDetailsInput) -> HighlightsDetailsViewController {
        let view = HighlightsDetailsViewController()
        let interactor = HighlightsDetailsInteractor()
        let router = HighlightsDetailsRouter(viewController: view)
        let presenter = HighlightsDetailsPresenter(view: view,
                                                   interactor: interactor,
                                                   router: router,
                                                   highlight: input.highlight)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol HighlightsDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectTappedImage(image: UIImage)
}

// Presenter --> Controller
protocol HighlightsDetailsControllerProtocol: AnyObject {
    func configureHighlightsUI(with highlight: HighlightsNews)
    func showFailureAlert(with error: String)
}

// Presenter --> Interactor
protocol HighlightsDetailsPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol HighlightsDetailsInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol HighlightsDetailsRouterProtocol: AnyObject {
    func showFullImage(image: UIImage)
    func popViewController()
}
