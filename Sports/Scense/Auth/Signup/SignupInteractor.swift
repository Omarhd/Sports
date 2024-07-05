//
//  SignupInteractor.swift
//  Sports
//
//  Created by ios Dev on 04/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

class SignupInteractor {

    var presenter: SignupInteractorOutput?
    private let session: Session
    private let base = BuildSettingsKey.AUTH.value
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Session = .shared) {
        self.session = session
    }
}
extension SignupInteractor: SignupPresenterInteractorProtocol {
    
    func signup(with parameters: signupRequest) {
        self.presenter?.showLoading()
        guard let url = URL(string: base + "register") else { fatalError("Invalid URL") }
        let newsList: AnyPublisher<SignupEntity, Error> = session.postRequest(to: url, with: parameters)
        
        newsList.receive(on: RunLoop.main)
            .sink { [weak self] Result in
                switch Result {
                case .failure(let error):
                    self?.presenter?.didFailedSignup(error: error)
                case .finished:
                    self?.presenter?.dismissLoading()
                }
            } receiveValue: { [weak self] signupResponse in
                self?.presenter?.succeedSignup(signupEntity: signupResponse)
                self?.presenter?.dismissLoading()
            }
            .store(in: &anyCancellable)
    }
}

