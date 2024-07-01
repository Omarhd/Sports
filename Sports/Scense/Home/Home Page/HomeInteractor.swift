//
//  HomeInteractor.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

class HomeInteractor {

    var presenter: HomeInteractorOutput?

    private let session: Session
    private let base = BuildSettingsKey.HIGHLIGHTS.value
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Session = .shared) {
        self.session = session
    }
}

extension HomeInteractor: HomePresenterInteractorProtocol {
  
    func fetchStories() {
        presenter?.succeedReceivedStories(stories: stories)
    }
    
    func fetchHighlight() {
        self.presenter?.showLoading()
        guard let url = URL(string: base + "forum/hotnews/elite") else { fatalError("Invalid URL") }
        let tournament: AnyPublisher<HomeHighlightsEntity, Error> = session.request(from: url)
        
        tournament.receive(on: RunLoop.main)
            .sink { [weak self] Result in
                switch Result {
                case .failure(let error):
                    self?.presenter?.didFailedLoading(error: error)
                case .finished:
                    self?.presenter?.dismissLoading()
                    break
                }
            } receiveValue: { [weak self] highlights in
                self?.presenter?.succeedReceivedHighlights(highlights: highlights)
                self?.presenter?.dismissLoading()
            }
            .store(in: &anyCancellable)
    }
    
    func fetchPosts() {
        presenter?.succeedReceivedPosts(posts: homeEntity)
    }
    
}

