//
//  UserListRouterProtocol.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol UserListRouterProtocol: Routable, AnyObject {
    func showUserDetailModule(login: String)
}
