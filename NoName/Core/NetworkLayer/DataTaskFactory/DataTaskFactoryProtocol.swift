//
//  DataTaskFactoryProtocol.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol DataTaskFactoryProtocol {
    func dataTask(type: DataTaskRequestType,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
