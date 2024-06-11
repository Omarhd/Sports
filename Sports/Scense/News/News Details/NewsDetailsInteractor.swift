//
//  NewsDetailsInteractor.swift
//  Sports
//
//  Created by ios Dev on 06/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

class NewsDetailsInteractor {

    var presenter: NewsDetailsInteractorOutput?
    private let session: Session
    private let base = BuildSettingsKey.NEWS.value
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Session = .shared) {
        self.session = session
    }
}

extension NewsDetailsInteractor: NewsDetailsPresenterInteractorProtocol {
    
    func fetchNewsDetails(newsID: Int) {
        guard let url = URL(string: base + "post/en/\(newsID)") else { fatalError("Invalid URL") }
        let newsDetails: AnyPublisher<News, Error> = session.request(from: url)
        
        newsDetails.receive(on: RunLoop.main)
            .sink { [weak self] Result in
                switch Result {
                case .failure(let error):
                    self?.presenter?.didFailedLoadingNewsDetails(error: error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] news in
                self?.presenter?.succeedReceivedNewsDetails(newsDetails: news)
            }
            .store(in: &anyCancellable)
    }
}

