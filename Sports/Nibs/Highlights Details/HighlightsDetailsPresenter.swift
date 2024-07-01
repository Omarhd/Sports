//
//  HighlightsDetailsPresenter.swift
//  Sports
//
//  Created by ios Dev on 01/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HighlightsDetailsPresenter: NSObject {
    // MARK: - Properties
    private var view: HighlightsDetailsControllerProtocol?
    private var interactor: HighlightsDetailsPresenterInteractorProtocol?
    private var router: HighlightsDetailsRouterProtocol?
    private var highlight: HighlightsNews

    // MARK: - Init
    init(view: HighlightsDetailsControllerProtocol?,
         interactor: HighlightsDetailsPresenterInteractorProtocol?,
         router: HighlightsDetailsRouterProtocol?,
         highlight: HighlightsNews) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.highlight = highlight
    }
}
// MARK: Conform to HighlightsDetailsPresenterProtocol
extension HighlightsDetailsPresenter: HighlightsDetailsPresenterProtocol {
    
    func didSelectTappedImage(image: UIImage) {
        router?.showFullImage(image: image)
    }
    
    func viewDidLoad() {
        view?.configureHighlightsUI(with: highlight)
    }
}
// MARK: Conform to HighlightsDetailsInteractorOutput
extension HighlightsDetailsPresenter: HighlightsDetailsInteractorOutput {
}
