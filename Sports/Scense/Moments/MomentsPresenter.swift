//
//  MomentsPresenter.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MomentsPresenter: NSObject {
    // MARK: - Properites
    private var view: MomentsControllerProtocol?
    private var interactor: MomentsPresenterInteractorProtocol?
    private var router: MomentsRouterProtocol?

    // MARK: - Init
    init(view: MomentsControllerProtocol?,
         interactor: MomentsPresenterInteractorProtocol?,
         router: MomentsRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: Conform to MomentsPresenterProtocol
extension MomentsPresenter: MomentsPresenterProtocol {
    func viewDidLoad() {
        
    }
}
// MARK: Conform to MomentsInteractorOutputa
extension MomentsPresenter: MomentsInteractorOutput {
}
