//
//  NetworkServiceProtocol.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    @discardableResult
    func task(closure: (NetworkServiceProtocol) throws -> URLSessionDataTask,
              onCatchError: (Error) -> Void) -> URLSessionDataTask?
    
    func request<T: Decodable>(with request: RequestBuilderProtocol,
                               completion: @escaping (Result<T, Error>) -> Void) throws -> URLSessionDataTask
    func responseOnQueue(_ queue: DispatchQueue) -> Self
    func setDecoder(_ decoder: JSONDecoder) -> Self 
}
