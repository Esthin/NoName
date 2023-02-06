//
//  UserModuleFactoryProtocol.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

protocol UserModuleFactoryProtocol {
    func buildUserList() -> UIViewController
    func buildUserDetail(login: String) -> UIViewController
}
