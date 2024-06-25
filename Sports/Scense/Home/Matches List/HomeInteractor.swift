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
    
    func fetchDates() {
        let calendar = Calendar.current
        let today = Date()
        let dateRange = (-6...6).compactMap { calendar.date(byAdding: .day, value: $0, to: today) }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE dd MMM" // Updated date format
        
        let dates = dateRange.map { date -> DateModel in
            let specialDate = SpecialDate.from(date: date, calendar: calendar)
            let formattedString = specialDate.formattedString(dateFormatter: dateFormatter)
            return DateModel(date: date, formattedString: formattedString)
        }
        self.presenter?.didFetchDates(dates)
    }
    
    func fetchMatches(parameters: MatchesRequest) {
        self.presenter?.showLoading()
        guard let url = URL(string: base + "basketball/matchlist") else { fatalError("Invalid URL") }
        let tournament: AnyPublisher<HomeEntity, Error> = session.requestQuery(from: url, withQueryParams: parameters)
        
        tournament.receive(on: RunLoop.main)
            .sink { [weak self] Result in
                switch Result {
                case .failure(let error):
                    self?.presenter?.didFailedLoadingMatches(error: error)
                    self?.presenter?.dismissLoading()
                case .finished:
                    self?.presenter?.dismissLoading()
                    break
                }
            } receiveValue: { [weak self] matches in
                self?.presenter?.succeedReceivedMatches(matchesData: matches)
                self?.presenter?.dismissLoading()
            }
            .store(in: &anyCancellable)
    }
    
    func fetchLiveMatches(parameters: LiveMatchesRequest) {
        self.presenter?.showLoading()
        guard let url = URL(string: base + "basketball/matchlist/live") else { fatalError("Invalid URL") }
        let tournament: AnyPublisher<HomeEntity, Error> = session.requestQuery(from: url, withQueryParams: parameters)
        
        tournament.receive(on: RunLoop.main)
            .sink { [weak self] Result in
                switch Result {
                case .failure(let error):
                    self?.presenter?.didFailedLoadingMatches(error: error)
                    self?.presenter?.dismissLoading()
                case .finished:
                    self?.presenter?.dismissLoading()
                    break
                }
            } receiveValue: { [weak self] matches in
                self?.presenter?.succeedReceivedMatches(matchesData: matches)
                self?.presenter?.dismissLoading()
            }
            .store(in: &anyCancellable)
    }
}
