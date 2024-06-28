//
//  PostDetailsPresenter.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class PostDetailsPresenter: NSObject {
    // MARK: - Properites
    private var view: PostDetailsControllerProtocol?
    private var interactor: PostDetailsPresenterInteractorProtocol?
    private var router: PostDetailsRouterProtocol?

    // MARK: - Init
    init(view: PostDetailsControllerProtocol?,
         interactor: PostDetailsPresenterInteractorProtocol?,
         router: PostDetailsRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: Conform to PostDetailsPresenterProtocol
extension PostDetailsPresenter: PostDetailsPresenterProtocol {
    func viewDidLoad() {
        
    }
}
// MARK: Conform to PostDetailsInteractorOutputa
extension PostDetailsPresenter: PostDetailsInteractorOutput {
}
