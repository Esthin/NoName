//
//  DataTaskFactoryMock.swift
//
//  Created by Dmitry Kosyakov on 18.12.2022.
//

import Foundation
@testable import NoName

class DataTaskFactoryMock: DataTaskFactoryProtocol {
    
    let session: URLSession
    let delay: TimeInterval
    
    init(delay: TimeInterval = 0) {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [URLProtocolMock.self]
        self.session = URLSession(configuration: sessionConfiguration)
        self.delay = delay
    }
    
    func dataTask(type: NoName.DataTaskRequestType,
                  completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        switch type {
        case .url(let url):
            return session.dataTask(with: url) { [weak self] _, _, _ in
                guard let self = self else { return }
                DispatchQueue.global().asyncAfter(deadline: .now() + self.delay) {
                    let (data, response, error) = self.getResponse()()
                    completion(data, response, error)
                }
            }
        case .urlRequest(let request):
            return session.dataTask(with: request) { [weak self] _, _, _ in
                guard let self = self else { return }
                DispatchQueue.global().asyncAfter(deadline: .now() + self.delay) {
                    let (data, response, error) = self.getResponse()()
                    completion(data, response, error)
                }
            }
        }
                               }
        
    func getResponse() -> (() -> (Data?, URLResponse?, Error?)) {
        { (nil, nil, nil) }
    }
}

class CountableDataTaskFactoryMock: DataTaskFactoryMock {
    
    let lock = NSLock()
    
    var getResponseCallCount = 0
    
    override func getResponse() -> (() -> (Data?, URLResponse?, Error?)) {
        { [weak self] in
            self?.lock.lock()
            self?.getResponseCallCount += 1
            self?.lock.unlock()
            return (nil, nil, nil)
        }
    }
}
