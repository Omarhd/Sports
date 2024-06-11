//
//  SocialMediaPresenter.swift
//  Sports
//
//  Created by ios Dev on 24/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class SocialMediaPresenter: NSObject {
    // MARK: - Properites
    private var view: SocialMediaControllerProtocol?
    private var interactor: SocialMediaPresenterInteractorProtocol?
    private var router: SocialMediaRouterProtocol?

    // MARK: - Init
    init(view: SocialMediaControllerProtocol?,
         interactor: SocialMediaPresenterInteractorProtocol?,
         router: SocialMediaRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: Conform to SocialMediaPresenterProtocol
extension SocialMediaPresenter: SocialMediaPresenterProtocol {
    func viewDidLoad() {
        
    }
}
// MARK: Conform to SocialMediaInteractorOutputa
extension SocialMediaPresenter: SocialMediaInteractorOutput {
}
