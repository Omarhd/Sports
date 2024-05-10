//
//  HomeConfigurator.swift
//  Sports
//
//  Created by ios Dev on 09/05/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

struct HomeInput { }

final class HomeConfigurator {
    
    // MARK: Configuration
    class func viewController(input: HomeInput) -> HomeViewController {
        let storyBoard = UIStoryboard.init(name: "Home", bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return HomeViewController() }
        let interactor = HomeInteractor()
        let router = HomeRouter(viewController: view)
        let presenter = HomePresenter(view: view,
                                      interactor: interactor,
                                      router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol HomePresenterProtocol: AnyObject {
    var numberOfTournament: Int { get }
    func viewDidLoad()
    func configureCell(with cell: TournamentTableViewCell, for index: Int)
    func didSelect(for index: Int)
}

// Presenter --> Controller
protocol HomeControllerProtocol: AnyObject {
    func setEmptyState()
    func showFailureAlert(with error: String)
    func loadTableView()
}

// Presenter --> Interactor
protocol HomePresenterInteractorProtocol: AnyObject {
    func fetchHotMatches(parameters: TournamentRequest)
}

// Interactor --> Presenter
protocol HomeInteractorOutput: AnyObject {
    func succeedReceivedTournaments(tournamentData: HomeEntity)
    func didFailedLoadingTournaments(error: Error)
}

// Presenter --> Router
protocol HomeRouterProtocol: AnyObject {
    func popViewController()
    func navigateToDetails()
}

// Cell --> Protocol
protocol TournamentCellProtocol: AnyObject {
    func displayName(name: String)
}
