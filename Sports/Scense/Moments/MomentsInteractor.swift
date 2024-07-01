//
//  MomentsInteractor.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

class MomentsInteractor {

    var presenter: MomentsInteractorOutput?
    private let session: Session
    private let base = BuildSettingsKey.NEWS.value
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Session = .shared) {
        self.session = session
    }
}

extension MomentsInteractor: MomentsPresenterInteractorProtocol {
    
    func fetchFollowingMoments() {
        presenter?.succeedReceivedFollowing(moments: moments)
    }
    
    func fetchHighlightMoments() {
        presenter?.succeedReceivedHighlights(moments: moments)
    }

}

