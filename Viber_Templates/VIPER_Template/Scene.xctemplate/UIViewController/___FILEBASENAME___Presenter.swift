//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ___VARIABLE_sceneName___Presenter: NSObject {
    // MARK: - Properites
    private var view: ___VARIABLE_sceneName___ControllerProtocol?
    private var interactor: ___VARIABLE_sceneName___PresenterInteractorProtocol?
    private var router: ___VARIABLE_sceneName___RouterProtocol?

    // MARK: - Init
    init(view: ___VARIABLE_sceneName___ControllerProtocol?,
         interactor: ___VARIABLE_sceneName___PresenterInteractorProtocol?,
         router: ___VARIABLE_sceneName___RouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
// MARK: Conform to ___VARIABLE_sceneName___PresenterProtocol
extension ___VARIABLE_sceneName___Presenter: ___VARIABLE_sceneName___PresenterProtocol {
    func viewDidLoad() {
        
    }
}
// MARK: Conform to ___VARIABLE_sceneName___InteractorOutputa
extension ___VARIABLE_sceneName___Presenter: ___VARIABLE_sceneName___InteractorOutput {
}
