//
//  BottomSheetViewController.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController {
   
    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!
   
    // MARK: Properties
    var presenter: BottomSheetPresenterProtocol?
    let messageHelper: SwiftMessagesHelper

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
        tableView.registerCell(cell: OptionTableViewCell.self)
    }
}

extension BottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = CreateContentOptions(rawValue: section) else { return 0 }
        return presenter?.numberOfRowsInSection(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let optionCell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.viewIdentifier(), for: indexPath) as? OptionTableViewCell else { return UITableViewCell() }
        guard let section = CreateContentOptions(rawValue: indexPath.section) else { return UITableViewCell() }
        presenter?.configureOptionCell(in: section, for: optionCell, for: indexPath)
        return optionCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = CreateContentOptions(rawValue: indexPath.section) else { return 0 }
        return presenter?.heightForRowInSection(in: section) ?? 0
    }
}

extension BottomSheetViewController: BottomSheetControllerProtocol {
    
    func loadTableView() {
        tableView.setupTableView(viewController: self)
        loadTableAndCollection(tableView: tableView)
    }
    
    func setEmptyState() {
        setEmptyCase(imageName: "figure.soccer", title: "No Data", message: "Try again Later".localized, containerView: self.view)
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
