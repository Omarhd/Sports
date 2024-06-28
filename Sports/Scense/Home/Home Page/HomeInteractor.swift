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
    private let base = BuildSettingsKey.TOURNAMENTS.value
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
        presenter?.succeedReceivedHighlights(highlights: highlights)
    }
    
    func fetchPosts() {
        presenter?.succeedReceivedPosts(posts: homeEntity)
    }
    
}

