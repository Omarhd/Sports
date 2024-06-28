//
//  BottomSheetInteractor.swift
//  Sports
//
//  Created by ios Dev on 27/06/2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class BottomSheetInteractor {

    var presenter: BottomSheetInteractorOutput?

    init() {
    }
}
extension BottomSheetInteractor: BottomSheetPresenterInteractorProtocol {
   
    func fetchContentOptions() {
        presenter?.succeedReceivedContentOptions(options: CreateContentOptions.allCases)
    }
    

}

