//
//  UserListInteractorOutput.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol UserListInteractorOutput: AnyObject {
    func didRecieveUserList(_ result: Result<[UserResponseModel], Error>, since: Int)
}
