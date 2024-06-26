//
//  LiveInteractor.swift
//  Sports
//
//  Created by ios Dev on 20/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

class LiveInteractor {

    var presenter: LiveInteractorOutput?
    private let session: Session
    private let base = BuildSettingsKey.TOURNAMENTS.value
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Session = .shared) {
        self.session = session
    }
}
extension LiveInteractor: LivePresenterInteractorProtocol {
    
    func fetchLiveMatches(parameters: LiveMatchesRequest) {
        self.presenter?.showLoading()
        guard let url = URL(string: base + "basketball/matchlist/live") else { fatalError("Invalid URL") }
        let tournament: AnyPublisher<HomeEntity, Error> = session.requestQuery(from: url, withQueryParams: parameters)
        
        tournament.receive(on: RunLoop.main)
            .sink { [weak self] Result in
                switch Result {
                case .failure(let error):
                    self?.presenter?.didFailedLoadingMatches(error: error)
                case .finished:
                    self?.presenter?.dismissLoading()
                }
            } receiveValue: { [weak self] matches in
                self?.presenter?.succeedReceivedMatches(matchesData: matches)
                self?.presenter?.dismissLoading()
            }
            .store(in: &anyCancellable)
    }
    

}

