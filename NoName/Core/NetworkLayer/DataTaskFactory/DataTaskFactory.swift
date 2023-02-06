//
//  DataTaskFactory.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

final class DataTaskFactory {
    
}

extension DataTaskFactory: DataTaskFactoryProtocol {
    func dataTask(type: DataTaskRequestType,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        switch type {
        case .url(let url):
            return URLSession.shared.dataTask(with: url, completionHandler: completion)
        case .urlRequest(let request):
            return URLSession.shared.dataTask(with: request, completionHandler: completion)
        }
        
    }
}
