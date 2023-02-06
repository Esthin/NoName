//
//  UserNetworkService.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

final class UserNetworkService {
    
    let requestBuilder: UserRequestBuilderProtocol
    let networkService: NetworkServiceProtocol
    
    init(requestBuilder: UserRequestBuilderProtocol = UserRequestBuilder(),
         networkService: NetworkServiceProtocol = NetworkService()) {
        self.requestBuilder = requestBuilder
        self.networkService = networkService
    }
    
}

extension UserNetworkService: UserNetworkServiceProtocol {
    
    func fetchUserRepos(login: String, completion: @escaping ((Result<[UserRepositoryResponseModel], Error>) -> Void)) {
        networkService.task { task in
            try task
                .responseOnQueue(.main)
                .request(with: requestBuilder.buildUserReposRequest(login: login),
                         completion: completion)
        } onCatchError: {
            completion(.failure($0))
        }
    }
    
    func fetchUserDetail(login: String,
                         completion: @escaping ((Result<UserDetailResponseModel, Error>) -> Void)) {
        networkService.task { task in
            try task
                .responseOnQueue(.main)
                .setDecoder(JSONDecoder().setStrategy(.iso8601))
                .request(with: requestBuilder.buildUserDetailRequest(login: login),
                         completion: completion)
        } onCatchError: {
            completion(.failure($0))
        }
    }
    
    
    func fetchUsersList(since: Int,
                        completion: @escaping ((Result<[UserResponseModel], Error>) -> Void)) -> CancellableTask? {
        networkService.task { task in
            try task
                .responseOnQueue(.main)
                .request(with: requestBuilder.buildUsersListRequest(since: since),
                         completion: completion)
        } onCatchError: {
            completion(.failure($0))
        }
    }
    
}

