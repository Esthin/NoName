//
//  UserRequestBuilder.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

final class UserRequestBuilder {
    
    let requestBuilder: RequestBuilderProtocol
    
    init(requestBuilder: RequestBuilderProtocol = RequestBuilder()) {
        self.requestBuilder = requestBuilder
    }
    
}

extension UserRequestBuilder: UserRequestBuilderProtocol {
    
    func buildUserReposRequest(login: String) -> RequestBuilderProtocol {
        requestBuilder
            .baseRequest(base: .gitHub)
            .setMethod(.get)
            .setPath("/users/\(login)/repos")
    }
    
    func buildUserDetailRequest(login: String) -> RequestBuilderProtocol {
        requestBuilder
            .baseRequest(base: .gitHub)
            .setMethod(.get)
            .setPath("/users/\(login)")
    }
    
    func buildUsersListRequest(since: Int) -> RequestBuilderProtocol {
        requestBuilder
            .baseRequest(base: .gitHub)
            .setMethod(.get)
            .setPath("/users")
            .setParametres(["since":since.description])
    }
    
}
