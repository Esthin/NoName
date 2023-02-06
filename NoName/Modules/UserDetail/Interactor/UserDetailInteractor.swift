//
//  UserDetailInteractor.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

final class UserDetailInteractor {
    
    private let login: String
    private let networkService: UserNetworkServiceProtocol
    private let group = DispatchGroup()
    private weak var output: UserDetailInteractorOutput?
    
    let imageLoadingService: ImageLoadingServiceProtocol
    
    init(login: String,
         networkService: UserNetworkServiceProtocol = UserNetworkService(),
         imageLoadingService: ImageLoadingServiceProtocol = ImageLoadingService()) {
        self.login = login
        self.networkService = networkService
        self.imageLoadingService = imageLoadingService
    }
    
    private func fetchUserDetail(group: DispatchGroup,
                                 completion: @escaping (Result<UserDetailResponseModel, Error>) -> Void) {
        group.enter()
        networkService.fetchUserDetail(login: login,
                                       completion: { [weak group] result in
            completion(result)
            group?.leave()
        })
    }
    
    private func fetchUserRepos(group: DispatchGroup,
                                completion: @escaping (Result<[UserRepositoryResponseModel], Error>) -> Void) {
        group.enter()
        networkService.fetchUserRepos(login: login,
                                      completion: { [weak group] result in
            completion(result)
            group?.leave()
        })
    }
}

extension UserDetailInteractor: UserDetailInteractorInput {
    func attach(_ output: UserDetailInteractorOutput) {
        self.output = output
    }
    
    func fetchData() {
        var userDetailsResult: (() -> (Result<UserDetailResponseModel, Error>))?
        var userResposResult: (() -> (Result<[UserRepositoryResponseModel], Error>))?
        
        fetchUserRepos(group: group) { result in
            userResposResult = { result }
        }
        
        fetchUserDetail(group: group) { result in
            userDetailsResult = { result }
        }
        
        group.notify(queue: .main) { [weak output] in
            output?.didRecieveResponses(userDetailCompletion: userDetailsResult,
                                        userReposCompletion: userResposResult)
        }
    }
    
}
