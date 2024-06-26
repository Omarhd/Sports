//
//  NewsInteractor.swift
//  Sports
//
//  Created by ios Dev on 23/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

class NewsInteractor {

    var presenter: NewsInteractorOutput?
    private let session: Session
    private let base = BuildSettingsKey.NEWS.value
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Session = .shared) {
        self.session = session
    }
}

extension NewsInteractor: NewsPresenterInteractorProtocol {
   
    func fetchHotNews() {
        self.presenter?.showLoading()
        guard let url = URL(string: base + "post-list/en/1") else { fatalError("Invalid URL") }
        let newsList: AnyPublisher<NewsEntity, Error> = session.request(from: url)
        
        newsList.receive(on: RunLoop.main)
            .sink { [weak self] Result in
                switch Result {
                case .failure(let error):
                    self?.presenter?.didFailedLoadingHotNews(error: error)
                case .finished:
                    self?.presenter?.dismissLoading()
                }
            } receiveValue: { [weak self] news in
                self?.presenter?.succeedReceivedHotNews(newsData: news)
                self?.presenter?.dismissLoading()
            }
            .store(in: &anyCancellable)
    }
    
    func fetchNews(parameters: NewsRequest) {
        self.presenter?.showLoading()
        guard let url = URL(string: base + "post-list/en/\(parameters.pageNumber)") else { fatalError("Invalid URL") }
        let newsList: AnyPublisher<NewsEntity, Error> = session.request(from: url)
        
        newsList.receive(on: RunLoop.main)
            .sink { [weak self] Result in
                switch Result {
                case .failure(let error):
                    self?.presenter?.didFailedLoadingNews(error: error)
                case .finished:
                    self?.presenter?.dismissLoading()
                }
            } receiveValue: { [weak self] news in
                self?.presenter?.succeedReceivedNews(newsData: news)
                self?.presenter?.dismissLoading()
            }
            .store(in: &anyCancellable)
    }
}

