//
//  UserListPresenterOutput.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol UserListPresenterOutput: ConstrucatableTableViewInput {
    func showLoader()
    func hideLoader()
}
