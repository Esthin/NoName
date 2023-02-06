//
//  UserNetworkServiceProtocol.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol UserNetworkServiceProtocol {
    func fetchUsersList(since: Int,
                        completion: @escaping ((Result<[UserResponseModel], Error>) -> Void)) -> CancellableTask?
    func fetchUserDetail(login: String,
                         completion: @escaping ((Result<UserDetailResponseModel, Error>) -> Void))
    func fetchUserRepos(login: String,
                        completion: @escaping ((Result<[UserRepositoryResponseModel], Error>) -> Void))
}
