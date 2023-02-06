//
//  UserDetailViewModel.swift
//
//  Created by Dmitry Kosyakov on 18.12.2022.
//

import UIKit

struct UserDetailViewModel {
    let avatarUrlString: String
    let userName: String
    let userLogin: String
    let userRegisterString: String
    let onGetImage: ((URL, @escaping ((UIImage?) -> Void)) -> Void)
}
