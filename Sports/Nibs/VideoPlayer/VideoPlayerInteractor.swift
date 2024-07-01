//
//  VideoPlayerInteractor.swift
//  Sports
//
//  Created by ios Dev on 29/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class VideoPlayerInteractor {

    var presenter: VideoPlayerInteractorOutput?

    init() {
    }
}
extension VideoPlayerInteractor: VideoPlayerPresenterInteractorProtocol {

    func fetchVideo() {
        presenter?.succeedLoadedVideo(urls: ["https://videos.pexels.com/video-files/4267811/4267811-uhd_2560_1440_30fps.mp4",
                                             "https://videos.pexels.com/video-files/4267811/4267811-uhd_2560_1440_30fps.mp4",
                                             "https://videos.pexels.com/video-files/4267811/4267811-uhd_2560_1440_30fps.mp4"])
    }
}

