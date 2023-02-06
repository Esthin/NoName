//
//  UserListRouter.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

final class UserListRouter {
    
    weak var viewController: UIViewController?
    private let moduleFactory: UserModuleFactoryProtocol
    
    init(viewController: UIViewController?,
         moduleFactory: UserModuleFactoryProtocol = UserModuleFactory()) {
        self.viewController = viewController
        self.moduleFactory = moduleFactory
    }
    
}

extension UserListRouter: UserListRouterProtocol {
    func showUserDetailModule(login: String) {
        push(moduleFactory.buildUserDetail(login: login))
    }
}

extension UserListRouter: BaseRouter, Routable {
    
}
