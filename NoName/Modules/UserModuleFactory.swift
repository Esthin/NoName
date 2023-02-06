//
//  UserModuleFactory.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

final class UserModuleFactory {
    
}

extension UserModuleFactory: UserModuleFactoryProtocol {
    
    func buildUserList() -> UIViewController {
        let viewController = UserListViewController()
        let router = UserListRouter(viewController: viewController)
        let interactor = UserListInteractor()
        let presenter = UserListPresenter(router: router,
                                          view: viewController,
                                          interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
    
    func buildUserDetail(login: String) -> UIViewController {
        let viewController = UserDetailViewController()
        let interactor = UserDetailInteractor(login: login)
        let router = UserDetailRouter(viewController: viewController)
        let presenter = UserDetailPresenter(router: router,
                                            view: viewController,
                                            interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
    
}
