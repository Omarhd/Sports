//
//  NewsDetailsPresenter.swift
//  Sports
//
//  Created by ios Dev on 06/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class NewsDetailsPresenter: NSObject {
    // MARK: - Proporties
    private var view: NewsDetailsControllerProtocol?
    private var interactor: NewsDetailsPresenterInteractorProtocol?
    private var router: NewsDetailsRouterProtocol?
    private var news: News
    
    // MARK: - Init
    init(view: NewsDetailsControllerProtocol?,
         interactor: NewsDetailsPresenterInteractorProtocol?,
         router: NewsDetailsRouterProtocol?, news: News) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.news = news
    }
}
// MARK: Conform to NewsDetailsPresenterProtocol
extension NewsDetailsPresenter: NewsDetailsPresenterProtocol {
    
    func viewDidLoad() {
        view?.configureNewsUI(with: news)
        interactor?.fetchNewsDetails(newsID: news.id ?? 1)
    }
}
// MARK: Conform to NewsDetailsInteractorOutput
extension NewsDetailsPresenter: NewsDetailsInteractorOutput {
    
    func succeedReceivedNewsDetails(newsDetails: News) {
        news = newsDetails
        view?.configureNewsUI(with: news)
    }
    
    func didFailedLoadingNewsDetails(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
    
}
