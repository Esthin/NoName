//
//  UserRequestBuilderProtocol.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol UserRequestBuilderProtocol {
    func buildUsersListRequest(since: Int) -> RequestBuilderProtocol
    func buildUserDetailRequest(login: String) -> RequestBuilderProtocol
    func buildUserReposRequest(login: String) -> RequestBuilderProtocol
}
