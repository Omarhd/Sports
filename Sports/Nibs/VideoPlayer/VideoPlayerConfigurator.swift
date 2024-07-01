//
//  VideoPlayerConfigurator.swift
//  Sports
//
//  Created by ios Dev on 29/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct VideoPlayerInput { 
    let videosURLs: [String]
}

final class VideoPlayerConfigurator {
    
    // MARK: Configuration
    class func viewController(input: VideoPlayerInput) -> VideoPlayerViewController {
        let view = VideoPlayerViewController()
        let interactor = VideoPlayerInteractor()
        let router = VideoPlayerRouter(viewController: view)
        let presenter = VideoPlayerPresenter(view: view,
                                             interactor: interactor,
                                             router: router,
                                             videosURLs: input.videosURLs)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol VideoPlayerPresenterProtocol: AnyObject {
    func viewDidLoad()
    func configureVideoCell(for cell: VideoTableViewCell, for index: Int, delegate: VideoPlayerCellDelegate)
    var numberOfRowsInSection: Int { get }
}

// Presenter --> Controller
protocol VideoPlayerControllerProtocol: AnyObject {
    func configureUI()
    func showFailureAlert(with error: String)
    func didFailedLoadingVideo()
    func showLoading()
    func dismissLoading()
}

// Presenter --> Interactor
protocol VideoPlayerPresenterInteractorProtocol: AnyObject {
    func fetchVideo()
}

// Interactor --> Presenter
protocol VideoPlayerInteractorOutput: AnyObject {
    func succeedLoadedVideo(urls: [String])
    func didFailedLoadingVideo(error: Error)
}
// Presenter --> Router
protocol VideoPlayerRouterProtocol: AnyObject {
    func popViewController()
}

protocol VideoPlayerCellProtocol: AnyObject {
    func configureCell(with url: URL)
}

protocol VideoPlayerCellDelegate: AnyObject {
    func videoDidFinishPlaying(in cell: VideoTableViewCell)
    func failedToPLayOrLoadVideo()
}
