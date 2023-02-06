//
//  UserResponseModel.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

struct UserResponseModel: Decodable {
    let userLogin: String
    let userId: Int
    let avatarUrlString: String
    
    enum CodingKeys: String, CodingKey {
        case userLogin = "login"
        case userId = "id"
        case avatarUrlString = "avatar_url"
    }
    
}
