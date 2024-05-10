//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ___VARIABLE_sceneName___Router {
    weak var viewController: ___VARIABLE_sceneName___ViewController?

    // MARK: - Init
    init(viewController: ___VARIABLE_sceneName___ViewController) {
        self.viewController = viewController
    }
}
// MARK: Conforming to ___VARIABLE_sceneName___RouterProtocol
extension ___VARIABLE_sceneName___Router: ___VARIABLE_sceneName___RouterProtocol {
    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
