//
//  CreateNewPostViewController.swift
//  Sports
//
//  Created by ios Dev on 02/07/2024.
//

import UIKit

class CreateNewPostViewController: UITableViewController {
        
    // MARK: Outlets
    
    // MARK: Properties
    var presenter: CreateNewPostPresenterProtocol?
    let messageHelper: SwiftMessagesHelper
    let imagePickerManager = ImagePickerManager()

    // MARK: - Initialiser
    init(messageHelper: SwiftMessagesHelper = .shared) {
        self.messageHelper = messageHelper
        super.init(nibName: nil, bundle: nil)
    }
            
    required init?(coder: NSCoder) {
        self.messageHelper = SwiftMessagesHelper.shared
        super.init(coder: coder)
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        tableView.registerCell(cell: UserTableViewCell.self)
        tableView.registerCell(cell: ContentTableViewCell.self)
        tableView.registerCell(cell: PublishTableViewCell.self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = CreatePostSections(rawValue: section) else { return 0 }
        return presenter?.numberOfRowsInSection(in: section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = CreatePostSections(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .user:
            guard let userCell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.viewIdentifier(), for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
            presenter?.configureUserCell(for: userCell, for: indexPath)
            
            return userCell
            
        case .content:
            guard let contentCell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.viewIdentifier(), for: indexPath) as? ContentTableViewCell else { return UITableViewCell() }
            presenter?.configureContentCell(for: contentCell, for: indexPath, delegate: self)

            return contentCell
        case .publish:
            guard let publishCell = tableView.dequeueReusableCell(withIdentifier: PublishTableViewCell.viewIdentifier(), for: indexPath) as? PublishTableViewCell else { return UITableViewCell() }
            presenter?.configurePublishCell(for: publishCell, for: indexPath)
            
            return publishCell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = CreatePostSections(rawValue: indexPath.section) else { return 0 }
        return presenter?.heightForRowInSection(in: section) ?? 0
    }
}

extension CreateNewPostViewController: ImagePickerCellDelegate {
    
    func didTapSelectImage(cell: ContentTableViewCell) {
        imagePickerManager.pickImage(self) { [weak self] image in
            guard let self = self else { return }
            if let indexPath = self.tableView.indexPath(for: cell) {
                cell.configureCellUI(with: image)
                cell.removeImageButton.isHidden = false
            }
        }
    }
    
    func didRemoveImage(cell: ContentTableViewCell) {
        cell.postImage.image = nil
        cell.removeImageButton.isHidden = true
    }
}

extension CreateNewPostViewController: CreateNewPostControllerProtocol {
    
    func setPageTitle(with title: String) {
        self.title = title
    }
    
    func loadTableView() {
        tableView.setupTableView(viewController: self)
        loadTableAndCollection(tableView: tableView)
    }
    
    func setEmptyState() {
        setEmptyCase(imageName: "ffigure.basketball", title: "No Data", message: "Try again Later".localized, containerView: self.view)
    }
    
    func showFailureAlert(with error: String) {
        messageHelper.showMessage(title: "\(error)", body: "Error While Fetching Data".localized, theme: .error, presentationStyle: .top, duration: .forever)
        setEmptyCase(imageName: "", title: "No Data".localized, message: "Try again Later".localized, containerView: self.view)
    }
    
    func showLoadingIndicator() {
        self.view.showLottieLoader(with: "LoadingBasket")
    }
    
    func showFailureIndicator() {
        self.view.hideLottieLoader()
    }
}
