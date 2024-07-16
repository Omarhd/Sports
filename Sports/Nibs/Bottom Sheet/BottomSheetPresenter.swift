//
//  BottomSheetPresenter.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class BottomSheetPresenter: NSObject {
    // MARK: - Properties
    private var view: BottomSheetControllerProtocol?
    private var interactor: BottomSheetPresenterInteractorProtocol?
    private var router: BottomSheetRouterProtocol?
    
    private var options: [CreateContentOptions] = []
    internal var numberOfSections: Int { return options.count }
    
    // MARK: - Init
    init(view: BottomSheetControllerProtocol?,
         interactor: BottomSheetPresenterInteractorProtocol?,
         router: BottomSheetRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: Conform to BottomSheetPresenterProtocol
extension BottomSheetPresenter: BottomSheetPresenterProtocol {

    func viewDidLoad() {
        interactor?.fetchContentOptions()
    }
    
    func numberOfRowsInSection(in section: CreateContentOptions) -> Int {
        switch section {
        case .Post: return 1
        case .Story: return 1
        case .Moment: return 1
        }
    }
    
    func heightForRowInSection(in section: CreateContentOptions) -> CGFloat {
        switch section {
        case .Post: return 50.0
        case .Story: return 50.0
        case .Moment: return 50.0
        }
    }
    
    func configureOptionCell(in section: CreateContentOptions, for cell: OptionTableViewCell, for index: IndexPath) {
        let cellData = options[index.section]
        cell.configureCell(with: cellData.description)
    }
    
    func didSelect(form section: CreateContentOptions) {
        switch section {
        case .Story: router?.opensCamera()
        case .Post: router?.openNewPost()
        case .Moment: router?.openToRecordVideo()
        }
    }
}

// MARK: Conform to BottomSheetInteractorOutput
extension BottomSheetPresenter: BottomSheetInteractorOutput {
    
    func succeedReceivedContentOptions(options: [CreateContentOptions]) {
        self.options = options
        options.isEmpty ? view?.setEmptyState() : view?.loadTableView()
    }
    
    func didFailedLoading(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
    
    func showLoading() {
        view?.showLoadingIndicator()
    }
    
    func dismissLoading() {
        view?.showFailureIndicator()
    }
}
