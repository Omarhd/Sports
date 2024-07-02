//
//  CreateNewPostInteractor.swift
//  Sports
//
//  Created by ios Dev on 02/07/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CreateNewPostInteractor {

    var presenter: CreateNewPostInteractorOutput?

    init() {
    }
}
extension CreateNewPostInteractor: CreateNewPostPresenterInteractorProtocol {
  
    func fetchPostOptions() {
        presenter?.succeedReceivedPostOptions(options: CreatePostSections.allCases)
    }
    

}

