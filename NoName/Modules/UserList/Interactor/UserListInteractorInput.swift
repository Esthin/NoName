//
//  UserListInteractorInput.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol UserListInteractorInput: AnyObject {
    var imageLoadingService: ImageLoadingServiceProtocol { get }
    
    func attach(_ output: UserListInteractorOutput)
    func fetchUsers(since: Int)
    func fetchUsers()
    func cancelUsersLoadingTask()
}

extension UserListInteractorInput {
    func fetchUsers() {
        fetchUsers(since: 0)
    }
}
