//
//  HomeInteractor.swift
//  Sports
//
//  Created by ios Dev on 09/05/2024.
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
    
    func fetchHotMatches(parameters: TournamentRequest) {
        self.presenter?.showLoading()
        guard let url = URL(string: base + "football/gettournament/unique") else { fatalError("Invalid URL") }
        let tournament: AnyPublisher<HomeEntity, Error> = session.requestQuery(from: url, withQueryParams: parameters)
        
        tournament.receive(on: RunLoop.main)
            .sink { [weak self] Result in
                switch Result {
                case .failure(let error):
                    self?.presenter?.didFailedLoadingTournaments(error: error)
                    self?.presenter?.dismissLoading()
                case .finished:
                    self?.presenter?.dismissLoading()
                    break
                }
            } receiveValue: { [weak self] tournaments in
                self?.presenter?.succeedReceivedTournaments(tournamentData: tournaments)
                self?.presenter?.dismissLoading()
            }
            .store(in: &anyCancellable)
    }
}
