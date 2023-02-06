//
//  UserDetailRouter.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

final class UserDetailRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension UserDetailRouter: UserDetailRouterProtocol {
    
}

extension UserDetailRouter: BaseRouter {
    
}
