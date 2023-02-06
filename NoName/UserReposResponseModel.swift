//
//  UserRepositoryResponseModel.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

struct UserRepositoryResponseModel: Decodable {
    let language: String?
    let forksCount: Int
    let watchers: Int
    let description: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case language
        case forksCount = "forks_count"
        case watchers = "watchers_count"
        case description
        case name
    }
    
}
