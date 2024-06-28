//
//  MatchOddsInteractor.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

class MatchOddsInteractor {

    var presenter: MatchOddsInteractorOutput?
    private let session: Session
    private let base = BuildSettingsKey.TOURNAMENTS.value
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Session = .shared) {
        self.session = session
    }
}
extension MatchOddsInteractor: MatchOddsPresenterInteractorProtocol {
    
    func fetchOddsData(with parameters: OddsRequest) {
        self.presenter?.showLoading()
        guard let url = URL(string: base + "basketball/matchlist/match/odd/detail/" + parameters.matchID) else { fatalError("Invalid URL") }
        let result: AnyPublisher<MatchOddsEntity, Error> = session.request(from: url)
        
        result.receive(on: RunLoop.main)
            .sink { [weak self] Result in
                switch Result {
                case .failure(let error):
                    self?.presenter?.didFailedLoadingOddsData(error: error)
                case .finished:
                    self?.presenter?.dismissLoading()
                    break
                }
            } receiveValue: { [weak self] odds in
                self?.presenter?.succeedReceivedOddsData(odds: odds)
                self?.presenter?.dismissLoading()
            }
            .store(in: &anyCancellable)
    }
    
    func fetchOddsSelectionOptions() {
        self.presenter?.didFetchedOddsSelectionOptions(options: OddsSelection.allCases)
    }

}

