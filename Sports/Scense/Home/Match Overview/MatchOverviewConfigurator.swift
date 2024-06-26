//
//  MatchOverviewConfigurator.swift
//  Sports
//
//  Created by ios Dev on 24/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct MatchOverviewInput { 
    let match: Match
}

final class MatchOverviewConfigurator {
    
    // MARK: Configuration
    class func viewController(input: MatchOverviewInput) -> MatchOverviewViewController {
        let view = MatchOverviewViewController()
        let interactor = MatchOverviewInteractor()
        let router = MatchOverviewRouter(viewController: view)
        let presenter = MatchOverviewPresenter(view: view,
                                               interactor: interactor,
                                               router: router,
                                               match: input.match)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol MatchOverviewPresenterProtocol: AnyObject {
    func viewDidLoad()
    func heightForRowInSection(in section: MatchOverviewSection) -> CGFloat
    func numberOfCells(in section: MatchOverviewSection) -> Int
    func configureVenueCell(with cell: VenueTableViewCell, for indexPath: IndexPath)
    func configureWeatherCell(with cell: WeatherTableViewCell, for indexPath: IndexPath)
    func configureTournamentCell(with cell: TournamentTableViewCell, for indexPath: IndexPath)
    
    var numberOfSections: Int { get }
}

// Presenter --> Controller
protocol MatchOverviewControllerProtocol: AnyObject {
    func reloadSection()
}

// Presenter --> Interactor
protocol MatchOverviewPresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol MatchOverviewInteractorOutput: AnyObject {
}
// Presenter --> Router
protocol MatchOverviewRouterProtocol: AnyObject {
    func popViewController()
}

// VenueCell --> Protocol
protocol VenueCellCellProtocol: AnyObject {
    func configureCellUI(venue: VenueDetails?)
}

// WeatherCell --> Protocol
protocol WeatherCellCellProtocol: AnyObject {
    func configureCellUI(weather: Weather?)
}

// WeatherCell --> Protocol
protocol TournamentCellCellProtocol: AnyObject {
    func configureCellUI(tournament: TournamentDetails?)
}

enum MatchOverviewSection: Int, CaseIterable {
    case venue
    case weather
    case tournament
}
