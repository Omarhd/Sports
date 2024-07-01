//
//  PostDetailsPresenter.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class PostDetailsPresenter: NSObject {
    // MARK: - Properties
    private var view: PostDetailsControllerProtocol?
    private var interactor: PostDetailsPresenterInteractorProtocol?
    private var router: PostDetailsRouterProtocol?
    private var post: Post

    // MARK: - Init
    init(view: PostDetailsControllerProtocol?,
         interactor: PostDetailsPresenterInteractorProtocol?,
         router: PostDetailsRouterProtocol?,
         post: Post) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.post = post
    }
}
// MARK: Conform to PostDetailsPresenterProtocol
extension PostDetailsPresenter: PostDetailsPresenterProtocol {
    
    func viewDidLoad() {
        view?.configurePostUI(with: post)
    }
    
    func didSelectTappedImage(image: UIImage) {
        router?.showFullImage(image: image)
    }
}

// MARK: Conform to PostDetailsInteractorOutput
extension PostDetailsPresenter: PostDetailsInteractorOutput {
}
