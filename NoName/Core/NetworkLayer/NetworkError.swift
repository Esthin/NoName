//
//  NetworkError.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

enum NetworkError: Error {
    case cantBuildUrl
    case responseCode(Int)
    case network(Error)
    case deserialize(Error)
    case emptyData
    case unknown
}
