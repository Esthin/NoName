//
//  UserModel.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

struct UserListElementViewModel {
    let name: String
    let id: Int
    let idDescription: String
    let avatarUrl: String
    let onGetImage: ((URL, @escaping ((UIImage?) -> Void)) -> Void)
    let onReuse: ((URL) -> Void)
}
