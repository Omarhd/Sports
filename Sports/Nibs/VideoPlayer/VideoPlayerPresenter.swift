//
//  VideoPlayerPresenter.swift
//  Sports
//
//  Created by ios Dev on 29/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import AVKit

final class VideoPlayerPresenter: NSObject {
    // MARK: - Properties
    private var view: VideoPlayerControllerProtocol?
    private var interactor: VideoPlayerPresenterInteractorProtocol?
    private var router: VideoPlayerRouterProtocol?
    private var videosURLs: [String]
    
    internal var numberOfRowsInSection: Int { return videosURLs.count }

    private var player: AVPlayer?
    private var currentPlayerIndexPath: IndexPath?
    
    // MARK: - Init
    init(view: VideoPlayerControllerProtocol?,
         interactor: VideoPlayerPresenterInteractorProtocol?,
         router: VideoPlayerRouterProtocol?, videosURLs: [String]) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.videosURLs = videosURLs
    }
}
// MARK: Conform to VideoPlayerPresenterProtocol
extension VideoPlayerPresenter: VideoPlayerPresenterProtocol {
    
    func viewDidLoad() {
        interactor?.fetchVideo()
    }
    
    func configureVideoCell(for cell: VideoTableViewCell, for index: Int, delegate: VideoPlayerCellDelegate) {
        guard let cellData = videosURLs[index].toURL() else { return }
        cell.delegate = delegate
        cell.configureCell(with: cellData)
    }
    
}

// MARK: Conform to VideoPlayerInteractorOutput
extension VideoPlayerPresenter: VideoPlayerInteractorOutput {
    
    func succeedLoadedVideo(urls: [String]) {
        self.videosURLs = urls
        urls.isEmpty ? view?.didFailedLoadingVideo() : view?.configureUI()
    }
    
    func didFailedLoadingVideo(error: Error) {
        view?.showFailureAlert(with: error.localizedDescription)
    }
    
}
