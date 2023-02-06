//
//  UserDetailPresenterOutput.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol UserDetailPresenterOutput: ConstrucatableTableViewInput {
    func showLoader()
    func hideLoader()
}
