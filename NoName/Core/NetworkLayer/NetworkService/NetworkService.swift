//
//  NetworkService.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

final class NetworkService {
    
    var resultQueue = DispatchQueue.main
    var decoder = JSONDecoder()
    var taskFactory: DataTaskFactoryProtocol
    
    init(queue: DispatchQueue = DispatchQueue.main,
         decoder: JSONDecoder = JSONDecoder(),
         taskFactory: DataTaskFactoryProtocol = DataTaskFactory()) {
        self.resultQueue = queue
        self.decoder = decoder
        self.taskFactory = taskFactory
    }
    
}

extension NetworkService: NetworkServiceProtocol {
    
    func request<T:Decodable>(with request: RequestBuilderProtocol,
                              completion: @escaping (Result<T, Error>) -> Void)
    throws -> URLSessionDataTask {
        try self.request(with: request,
                         on: resultQueue,
                         with: decoder,
                         completion: completion)
    }
    
    func responseOnQueue(_ queue: DispatchQueue) -> Self {
        self.resultQueue = queue
        return self
    }
    
    func setDecoder(_ decoder: JSONDecoder) -> Self {
        self.decoder = decoder
        return self
    }
    
    private func request<T:Decodable>(with request: RequestBuilderProtocol,
                                      on queue: DispatchQueue,
                                      with decoder: JSONDecoder,
                                      completion: @escaping (Result<T, Error>) -> Void)
    throws -> URLSessionDataTask {
        guard let urlRequest = try? request.build() else {
            assertionFailure()
            throw NetworkError.cantBuildUrl
        }
        
        return taskFactory.dataTask(type: .urlRequest(urlRequest)) { data, response, error in
            
            // TODO: Decomposition
            queue.async {
                if let error = error {
                    completion(.failure(NetworkError.network(error)))
                } else if let statusCode = response.flatMap({ $0 as? HTTPURLResponse })?.statusCode {
                    if (200...300).contains(statusCode) {
                        if let data = data {
                            do {
                                let result = try decoder.decode(T.self, from: data)
                                completion(.success(result))
                            } catch {
                                completion(.failure(NetworkError.deserialize(error)))
                            }
                        } else {
                            completion(.failure(NetworkError.emptyData))
                        }
                    } else {
                        completion(.failure(NetworkError.responseCode(statusCode)))
                    }
                } else {
                    completion(.failure(NetworkError.unknown))
                }
            }
        }
    }
    
    @discardableResult
    func task(closure: (NetworkServiceProtocol) throws -> URLSessionDataTask,
              onCatchError: (Error) -> Void) -> URLSessionDataTask? {
        do {
            let task = try closure(self)
            defer { task.resume() }
            return task
        } catch {
            defer { onCatchError(error) }
            return nil
        }
    }
    
}
