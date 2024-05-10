//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct ___VARIABLE_sceneName___Input { }

final class ___VARIABLE_sceneName___Configurator {
    
    // MARK: Configuration
    class func viewController(input: ___VARIABLE_sceneName___Input) -> ___VARIABLE_sceneName___ViewController {
        let view = ___VARIABLE_sceneName___ViewController()
        let interactor = ___VARIABLE_sceneName___Interactor()
        let router = ___VARIABLE_sceneName___Router(viewController: view)
        let presenter = ___VARIABLE_sceneName___Presenter(view: view,
                                                          interactor: interactor,
                                                          router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol ___VARIABLE_sceneName___PresenterProtocol: AnyObject {
    func viewDidLoad()
}

// Presenter --> Controller
protocol ___VARIABLE_sceneName___ControllerProtocol: AnyObject {
}

// Presenter --> Interactor
protocol ___VARIABLE_sceneName___PresenterInteractorProtocol: AnyObject {
}

// Interactor --> Presenter
protocol ___VARIABLE_sceneName___InteractorOutput: AnyObject {
}
// Presenter --> Router
protocol ___VARIABLE_sceneName___RouterProtocol: AnyObject {
    func popViewController()
}
