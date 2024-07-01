//
//  MomentsConfigurator.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct MomentsInput { }

final class MomentsConfigurator {
    
    // MARK: Configuration
    class func viewController(input: MomentsInput) -> MomentsViewController {
        let storyBoard = UIStoryboard.init(name: MomentsStoryboard, bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: "MomentsViewController") as? MomentsViewController else { return MomentsViewController() }
        let interactor = MomentsInteractor()
        let router = MomentsRouter(viewController: view)
        let presenter = MomentsPresenter(view: view,
                                                          interactor: interactor,
                                                          router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol MomentsPresenterProtocol: AnyObject {
    func viewDidLoad()
    
    func numberOfRowsInSection(in section: MomentsSections) -> Int
    func heightForRowInSection(in section: MomentsSections) -> CGFloat?

    func configureHighlightsCell(for cell: HighlightMomentTableViewCell, delegate: MomentsCollectionCellViewControllerProtocol?)
    func configureFollowingCell(for cell: FollowingMomentTableViewCell, delegate: MomentsCollectionCellViewControllerProtocol?)

    func viewForHeaderInSection(in section: MomentsSections, for sectionView: HighlightHeaderTableViewCell)
    func heightForHeaderInSection(in section: MomentsSections) -> CGFloat?
    
    func didTappedMoment(with moment: MomentsEntity, allMoments: [MomentsEntity])
    
    var numberOfSections: Int { get }
}

// Presenter --> Controller
protocol MomentsControllerProtocol: AnyObject {
    func setEmptyState()
    func showFailureAlert(with error: String)
    func loadTableView()
    func showLoadingIndicator()
    func showFailureIndicator()
}

// Presenter --> Interactor
protocol MomentsPresenterInteractorProtocol: AnyObject {
    func fetchHighlightMoments()
    func fetchFollowingMoments()
}

// Interactor --> Presenter
protocol MomentsInteractorOutput: AnyObject {
    func succeedReceivedFollowing(moments: [MomentsEntity])
    func succeedReceivedHighlights(moments: [MomentsEntity])
    func didFailedLoading(error: Error)
    func showLoading()
    func dismissLoading()
}

// Presenter --> Router
protocol MomentsRouterProtocol: AnyObject {
    func popViewController()
    func showFullMoment(story: MomentsEntity, allStories: [MomentsEntity])
}

protocol FollowingMomentCellProtocol: AnyObject {
    func configureCell(with moments: [MomentsEntity])
}

protocol HighlightMomentCellProtocol: AnyObject {
    func configureCell(with moments: [MomentsEntity])
}

protocol MomentCollectionViewCellProtocol: AnyObject {
    func configureCell(with moment: MomentsEntity)
}

protocol MomentsCollectionCellViewControllerProtocol: AnyObject {
    func didTappedMoment(with moment: MomentsEntity, allMoments: [MomentsEntity])
}
