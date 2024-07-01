//
//  PostDetailsConfigurator.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct PostDetailsInput { 
    let post: Post
}

final class PostDetailsConfigurator {
    
    // MARK: Configuration
    class func viewController(input: PostDetailsInput) -> PostDetailsViewController {
        let view = PostDetailsViewController()
        let interactor = PostDetailsInteractor()
        let router = PostDetailsRouter(viewController: view)
        let presenter = PostDetailsPresenter(view: view,
                                             interactor: interactor,
                                             router: router,
                                             post: input.post)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol PostDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectTappedImage(image: UIImage)
}

// Presenter --> Controller
protocol PostDetailsControllerProtocol: AnyObject {
    func configurePostUI(with post: Post?)
}

// Presenter --> Interactor
protocol PostDetailsPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol PostDetailsInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol PostDetailsRouterProtocol: AnyObject {
    func popViewController()
    func showFullImage(image: UIImage)
}
