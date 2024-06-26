//
//  MatchStandingInteractor.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

class MatchStandingInteractor {

    var presenter: MatchStandingInteractorOutput?
    private let session: Session
    private let base = BuildSettingsKey.TOURNAMENTS.value
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Session = .shared) {
        self.session = session
    }
}

extension MatchStandingInteractor: MatchStandingPresenterInteractorProtocol {
    
    func fetchSeasonSelectionOptions() {
        presenter?.didFetchedSeasonSelectionOptions(options: SeasonSelection.allCases)
    }
    
    func fetchSeasonStandingData(with parameters: StandingSeasonRequest) {
        self.presenter?.showLoading()
        guard let url = URL(string: base + "basketball/standings/" + parameters.seasonID) else { fatalError("Invalid URL") }
        let result: AnyPublisher<StandingSeasonEntity, Error> = session.request(from: url)
        
        result.receive(on: RunLoop.main)
            .sink { [weak self] Result in
                switch Result {
                case .failure(let error):
                    self?.presenter?.didFailedLoadingSeasonData(error: error)
                case .finished:
                    self?.presenter?.dismissLoading()
                    break
                }
            } receiveValue: { [weak self] season in
                self?.presenter?.succeedReceivedStandingSeasonData(season: season)
                self?.presenter?.dismissLoading()
            }
            .store(in: &anyCancellable)
    }

}

