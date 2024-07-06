//
//  SignInInteractor.swift
//  Sports
//
//  Created by ios Dev on 06/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Combine

class SignInInteractor {

    var presenter: SignInInteractorOutput?
    private let session: Session
    private let base = BuildSettingsKey.AUTH.value
    private var anyCancellable = Set<AnyCancellable>()
    
    init(session: Session = .shared) {
        self.session = session
    }
}
extension SignInInteractor: SignInPresenterInteractorProtocol {
    
    func signup(with parameters: SignInRequest) {
        self.presenter?.showLoading()
        guard let url = URL(string: base + "register") else { fatalError("Invalid URL") }
        let signInRequest: AnyPublisher<SignInEntity, Error> = session.postRequest(to: url, with: parameters)
        
        signInRequest.receive(on: RunLoop.main)
            .sink { [weak self] Result in
                switch Result {
                case .failure(let error):
                    self?.presenter?.didFailedSignIn(error: error)
                    self?.presenter?.dismissLoading()
                case .finished:
                    self?.presenter?.dismissLoading()
                }
            } receiveValue: { [weak self] signInResponse in
                self?.presenter?.succeedSignIn(signInEntity: signInResponse)
                self?.presenter?.dismissLoading()
            }
            .store(in: &anyCancellable)
    }
    

}

