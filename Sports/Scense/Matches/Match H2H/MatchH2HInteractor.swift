//
//  MatchH2HInteractor.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

class MatchH2HInteractor {

    var presenter: MatchH2HInteractorOutput?
    private let session: Session
    private let base = BuildSettingsKey.TOURNAMENTS.value
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Session = .shared) {
        self.session = session
    }
}

extension MatchH2HInteractor: MatchH2HPresenterInteractorProtocol {
    
    func fetchH2HSelectionOptions() {
        self.presenter?.didFetchedH2HSelectionOptions(options: TeamSelection.allCases)
    }
    
    func fetchH2HData(with parameters: HeadToHeadRequest) {
        self.presenter?.showLoading()
        guard let url = URL(string: base + "basketball/get/H2H") else { fatalError("Invalid URL") }
        let tournament: AnyPublisher<MatchH2HEntity, Error> = session.requestQuery(from: url, withQueryParams: parameters)
        
        tournament.receive(on: RunLoop.main)
            .sink { [weak self] Result in
                switch Result {
                case .failure(let error):
                    self?.presenter?.didFailedLoadingH2HData(error: error)
                case .finished:
                    self?.presenter?.dismissLoading()
                    break
                }
            } receiveValue: { [weak self] h2h in
                self?.presenter?.succeedReceivedH2HData(h2hData: h2h)
                self?.presenter?.dismissLoading()
            }
            .store(in: &anyCancellable)
    }
}

