//
//  CreateNewPostInteractor.swift
//  Sports
//
//  Created by ios Dev on 02/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

class CreateNewPostInteractor {

    var presenter: CreateNewPostInteractorOutput?

    private let session: Session
    private let base = BuildSettingsKey.HIGHLIGHTS.value
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Session = .shared) {
        self.session = session
    }
}
extension CreateNewPostInteractor: CreateNewPostPresenterInteractorProtocol {
  
    func fetchPostOptions() {
        presenter?.succeedReceivedPostOptions(options: CreatePostSections.allCases)
    }
    
    func publishPost(with parameters: PublishPostEntity) {
        self.presenter?.showLoading()
        guard let url = URL(string: base + "forum/hotnews/elite") else { fatalError("Invalid URL") }
        let tournament: AnyPublisher<PublishedPostEntity, Error> = session.postRequest(to: url, with: parameters)
        
        tournament.receive(on: RunLoop.main)
            .sink { [weak self] Result in
                switch Result {
                case .failure(let error):
                    self?.presenter?.didFailedLoading(error: error)
                case .finished:
                    self?.presenter?.dismissLoading()
                    break
                }
            } receiveValue: { [weak self] post in
                self?.presenter?.succeedPostPublished(post: post)
                self?.presenter?.dismissLoading()
            }
            .store(in: &anyCancellable)
    }
}

