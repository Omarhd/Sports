//
//  CreateNewPostConfigurator.swift
//  Sports
//
//  Created by ios Dev on 02/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct CreateNewPostInput { }

final class CreateNewPostConfigurator {
    
    // MARK: Configuration
    class func viewController(input: CreateNewPostInput) -> CreateNewPostViewController {
        let view = CreateNewPostViewController()
        let interactor = CreateNewPostInteractor()
        let router = CreateNewPostRouter(viewController: view)
        let presenter = CreateNewPostPresenter(view: view,
                                                          interactor: interactor,
                                                          router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol CreateNewPostPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfRowsInSection(in section: CreatePostSections) -> Int
    func heightForRowInSection(in section: CreatePostSections) -> CGFloat
    func configureUserCell(for cell: UserTableViewCell, for index: IndexPath)
    func configureContentCell(for cell: ContentTableViewCell, for index: IndexPath, delegate: ImagePickerCellDelegate)
    func configurePublishCell(for cell: PublishTableViewCell, for index: IndexPath, delegate: PublishCellDelegateProtocol?)

    func publishPost()
    func succeedPublishedPost()
    
    var numberOfSections: Int { get }
}

// Presenter --> Controller
protocol CreateNewPostControllerProtocol: AnyObject {
    func setPageTitle(with title: String)
    func setEmptyState()
    func showFailureAlert(with error: String)
    func loadTableView()
    func showLoadingIndicator()
    func showFailureIndicator()
    func succeedPublishedPost()
}

// Presenter --> Interactor
protocol CreateNewPostPresenterInteractorProtocol: AnyObject {
    func fetchPostOptions()
    func publishPost(with parameters: PublishPostEntity)
}

// Interactor --> Presenter
protocol CreateNewPostInteractorOutput: AnyObject {
    func succeedReceivedPostOptions(options: [CreatePostSections])
    func succeedPostPublished(post: PublishedPostEntity)
    func didFailedLoading(error: Error)
    func showLoading()
    func dismissLoading()
}
// Presenter --> Router
protocol CreateNewPostRouterProtocol: AnyObject {
    func popViewController()
}

protocol UserCellProtocol: AnyObject {
    func configureCellUI(with user: User)
}

protocol ContentCellProtocol: AnyObject {
    func configureCellUI(with image: UIImage?)
}

protocol ImagePickerCellDelegate: AnyObject {
    func didTapSelectImage(cell: ContentTableViewCell)
    func didTapCameraImage(cell: ContentTableViewCell)
    func didTapLibraryImage(cell: ContentTableViewCell)
    func didRemoveImage(cell: ContentTableViewCell)
}

protocol PublishCellProtocol: AnyObject {
    func configureCellUI()
}

protocol PublishCellDelegateProtocol: AnyObject {
    func publishPost()
}
