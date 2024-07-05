//
//  BottomSheetConfigurator.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct BottomSheetInput { }

final class BottomSheetConfigurator {
    
    // MARK: Configuration
    class func viewController(input: BottomSheetInput) -> BottomSheetViewController {
        let view = BottomSheetViewController()
        let interactor = BottomSheetInteractor()
        let router = BottomSheetRouter(viewController: view)
        let presenter = BottomSheetPresenter(view: view,
                                                          interactor: interactor,
                                                          router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol BottomSheetPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfRowsInSection(in section: CreateContentOptions) -> Int
    func heightForRowInSection(in section: CreateContentOptions) -> CGFloat
    func configureOptionCell(in section: CreateContentOptions, for cell: OptionTableViewCell, for index: IndexPath)

    func didSelect(form section: CreateContentOptions)
    
    var numberOfSections: Int { get }

}

// Presenter --> Controller
protocol BottomSheetControllerProtocol: AnyObject {
    func setEmptyState()
    func showFailureAlert(with error: String)
    func loadTableView()
    func showLoadingIndicator()
    func showFailureIndicator()
}

// Presenter --> Interactor
protocol BottomSheetPresenterInteractorProtocol: AnyObject {
    func fetchContentOptions()
}

// Interactor --> Presenter
protocol BottomSheetInteractorOutput: AnyObject {
    func succeedReceivedContentOptions(options: [CreateContentOptions])
    func didFailedLoading(error: Error)
    func showLoading()
    func dismissLoading()
}

// Presenter --> Router
protocol BottomSheetRouterProtocol: AnyObject {
    func popViewController()
    func opensCamera()
    func openNewPost()
    func openToRecordVideo()
}

protocol OptionsCellProtocol: AnyObject {
    func configureCell(with title: String)
}
