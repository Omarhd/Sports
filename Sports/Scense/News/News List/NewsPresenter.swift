//
//  NewsPresenter.swift
//  Sports
//
//  Created by ios Dev on 23/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class NewsPresenter: NSObject {
    
    // MARK: - Properties
    private var view: NewsControllerProtocol?
    private var interactor: NewsPresenterInteractorProtocol?
    private var router: NewsRouterProtocol?
    
    var currentPage: Int = 2
    var hotNews: [News] = []
    var listNews: [News] = []
    var numberOfSections: Int { return NewsSection.allCases.count }
    
    // MARK: - Init
    init(view: NewsControllerProtocol?,
         interactor: NewsPresenterInteractorProtocol?,
         router: NewsRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Conform to NewsPresenterProtocol
extension NewsPresenter: NewsPresenterProtocol {
    
    func numberOfNews(in section: NewsSection) -> Int {
        switch section {
        case .hotNews:
            return hotNews.isEmpty ? (0) : (1)
        case .listNews:
            return listNews.isEmpty ? (0) : (listNews.count)
        }
    }
    
    func heightForRowInSection(in section: NewsSection) -> CGFloat {
        switch section {
        case .hotNews:
            return hotNews.isEmpty ? (0) : (400.0)
        case .listNews:
            return listNews.isEmpty ? (0) : (80.0)
        }
    }
    
    func configureHotNewsCell(with cell: HotNewsTableViewCell, for indexPath: IndexPath) {
        var cellData: News?
        indexPath.row < hotNews.count ? (cellData = hotNews[indexPath.row]) : ()
        cell.configureCellUI(news: cellData)
    }
    
    func configureListNewsCell(with cell: ListNewsTableViewCell, for indexPath: IndexPath) {
        var cellData: News?
        indexPath.row < listNews.count ? (cellData = listNews[indexPath.row]) : ()
        cell.configureCellUI(news: cellData)
    }
    
    func didSelectNews(at indexPath: IndexPath) {
        switch NewsSection(rawValue: indexPath.section) {
        case .hotNews:
            router?.navigateToDetails(news: hotNews[indexPath.row])
            return
        case .listNews:
            router?.navigateToDetails(news: listNews[indexPath.row])
        case .none:
            return
        }
    }
    
    func viewDidLoad() {
        interactor?.fetchHotNews()

        let newsParameters = NewsRequest(pageNumber: 2)
        let parameters: NewsRequest = newsParameters
        interactor?.fetchNews(parameters: parameters)
    }
}

// MARK: Conform to NewsInteractor Output
extension NewsPresenter: NewsInteractorOutput {
   
    func succeedReceivedHotNews(newsData: NewsEntity) {
        hotNews = newsData.list ?? []
        hotNews.isEmpty ? (view?.setEmptyState()) : (view?.reloadSection(.hotNews))
    }
    
    func succeedReceivedNews(newsData: NewsEntity) {
        listNews = newsData.list ?? []
        listNews.isEmpty ? (view?.setEmptyState()) : (view?.reloadSection(.listNews))
    }
    
    func didFailedLoadingNews(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
    
    func didFailedLoadingHotNews(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
    
    func showLoading() {
        view?.showLoadingIndicator()
    }
    
    func dismissLoading() {
        view?.showFailureIndicator()
    }
}
