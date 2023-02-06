//
//  UserDetailResponseModel.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

struct UserDetailResponseModel: Decodable {
    let userLogin: String
    let userName: String
    let avatarUrlString: String
    let userRegisterDate: Date
    
    enum CodingKeys: String, CodingKey {
        case userLogin = "login"
        case userName = "name"
        case avatarUrlString = "avatar_url"
        case userRegisterDate = "created_at"
    }
    
}
