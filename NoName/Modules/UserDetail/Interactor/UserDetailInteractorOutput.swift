//
//  UserDetailInteractorOutput.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol UserDetailInteractorOutput: AnyObject {
    func didRecieveResponses(userDetailCompletion: (() -> (Result<UserDetailResponseModel, Error>))?,
                             userReposCompletion: (() -> (Result<[UserRepositoryResponseModel], Error>))?)
}
