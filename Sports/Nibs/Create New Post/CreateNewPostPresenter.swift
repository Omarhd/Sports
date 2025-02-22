//
//  CreateNewPostPresenter.swift
//  Sports
//
//  Created by ios Dev on 02/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class CreateNewPostPresenter: NSObject {
    // MARK: - Properties
    private var view: CreateNewPostControllerProtocol?
    private var interactor: CreateNewPostPresenterInteractorProtocol?
    private var router: CreateNewPostRouterProtocol?

    private var options: [CreatePostSections] = []
    internal var numberOfSections: Int { return options.count }
    
    // MARK: - Publish Post Parameters
    var content: String?
    var image: UIImage?
    
    // MARK: - Init
    init(view: CreateNewPostControllerProtocol?,
         interactor: CreateNewPostPresenterInteractorProtocol?,
         router: CreateNewPostRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: Conform to CreateNewPostPresenterProtocol
extension CreateNewPostPresenter: CreateNewPostPresenterProtocol {
    
    func viewDidLoad() {
        interactor?.fetchPostOptions()
        view?.setPageTitle(with: "New Post".localized)
    }
    
    func publishPost() {
        let parameters: PublishPostEntity = .init(content: content ?? "")
        interactor?.publishPost(with: parameters)
    }
    
    func succeedPublishedPost() {
        router?.popViewController()
    }
    
    func numberOfRowsInSection(in section: CreatePostSections) -> Int {
        switch section {
        case .user: return 1
        case .content: return 1
        case .publish: return 1
        }
    }
    
    func heightForRowInSection(in section: CreatePostSections) -> CGFloat {
        switch section {
        case .user: return 80.0
        case .content: return 280.0
        case .publish: return 80.0
        }
    }
    
    func configureUserCell(for cell: UserTableViewCell, for index: IndexPath) {
        let user: User = .init(id: 0,
                               name: "John Doe",
                               email: "mail@mail.mail",
                               emailVerifiedAt: "",
                               createdAt: "",
                               updatedAt: "")
        cell.configureCellUI(with: user)
    }
    
    func configureContentCell(for cell: ContentTableViewCell, for index: IndexPath, delegate: ImagePickerCellDelegate) {
        cell.delegate = delegate
        cell.configureCellUI(with: nil)
    }
    
    func configurePublishCell(for cell: PublishTableViewCell, for index: IndexPath, delegate: PublishCellDelegateProtocol?) {
        cell.delegate = delegate
        cell.configureCellUI()
    }

}
// MARK: Conform to CreateNewPostInteractorOutput
extension CreateNewPostPresenter: CreateNewPostInteractorOutput {
   
    func succeedPostPublished(post: PublishedPostEntity) {
        view?.succeedPublishedPost()
    }
    
    func succeedReceivedPostOptions(options: [CreatePostSections]) {
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
