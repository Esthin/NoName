//
//  UserListInteractor.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

final class UserListInteractor {
    
    weak var output: UserListInteractorOutput?
    private let networkService: UserNetworkServiceProtocol
    let imageLoadingService: ImageLoadingServiceProtocol
    private weak var userLoadingTask: CancellableTask?
    
    init(networkService: UserNetworkServiceProtocol = UserNetworkService(),
         imageLoadingService: ImageLoadingServiceProtocol = ImageLoadingService()) {
        self.networkService = networkService
        self.imageLoadingService = imageLoadingService
    }
    
}

extension UserListInteractor: UserListInteractorInput {
    
    func cancelUsersLoadingTask() {
        userLoadingTask?.cancel()
    }
    
    func attach(_ output: UserListInteractorOutput) {
        self.output = output
    }
    
    func fetchUsers(since: Int) {
        guard userLoadingTask?.isRunning != true else {
            return
        }
        
        userLoadingTask = networkService.fetchUsersList(since: since) { [weak output] result in
            output?.didRecieveUserList(result, since: since)
        }
    }
    
}
