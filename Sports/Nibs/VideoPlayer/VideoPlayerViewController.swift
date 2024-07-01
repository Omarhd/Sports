//
//  VideoPlayerViewController.swift
//  Sports
//
//  Created by ios Dev on 29/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
   
    // MARK: Properties
    var presenter: VideoPlayerPresenterProtocol?
    let messageHelper: SwiftMessagesHelper
    var scrollPosition: ScrollPosition = .top

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
        navigationController?.isNavigationBarHidden = true
        presenter?.viewDidLoad()
        tableView.registerCell(cell: VideoTableViewCell.self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension VideoPlayerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.viewIdentifier(), for: indexPath) as? VideoTableViewCell else {
            return UITableViewCell()
        }
        cell.index = indexPath.row
        presenter?.configureVideoCell(for: cell, for: indexPath.row, delegate: self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height
    }
}

extension VideoPlayerViewController: UIScrollViewDelegate {
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if offsetY < 0 {
            scrollPosition = .top
        } else if offsetY + scrollViewHeight >= contentHeight {
            if scrollView.isDragging && offsetY > scrollView.contentSize.height - scrollView.frame.size.height {
                scrollPosition = .bottom
            }
        } else {
            scrollPosition = .middle
        }
        
        switch scrollPosition {
        case .top:
            handleTopScroll()
        case .bottom:
            handleBottomScroll()
        case .middle:
            handleMiddleScroll()
        }
    }
    
    func handleTopScroll() {
        dismissViewController()
    }
    
    func handleBottomScroll() {
        dismissViewController()
    }
    
    func handleMiddleScroll() {

    }
    
    private func dismissViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension VideoPlayerViewController: VideoPlayerCellDelegate {
    
    func videoDidFinishPlaying(in cell: VideoTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        if indexPath.row < presenter?.numberOfRowsInSection ?? 0 - 1 {
            let nextIndexPath = IndexPath(row: indexPath.row + 1, section: 0)
            tableView.scrollToRow(at: nextIndexPath, at: .middle, animated: true)
        } else {
            dismissViewController()
        }
    }
    
    func failedToPLayOrLoadVideo() {
        self.messageHelper.showMessage(title: "Error Loading ", body: "", theme: .warning, presentationStyle: .top, duration: .seconds(seconds: 3.0))
        self.navigationController?.popToRootViewController(animated: true)
    }
}


extension VideoPlayerViewController: VideoPlayerControllerProtocol {
    
    func configureUI() {
        tableView.setupTableView(viewController: self)
    }
    
    func showFailureAlert(with error: String) {
        messageHelper.showMessage(title: "\(error)", body: "Error While Fetching Data".localized, theme: .error, presentationStyle: .top, duration: .seconds(seconds: 3.0))
        setEmptyCase(imageName: "", title: "No Data".localized, message: "Try again Later".localized, containerView: self.view)
    }
    
    func didFailedLoadingVideo() {
    
    }
    
    func showLoading() {
    
    }
    
    func dismissLoading() {
    
    }
}

