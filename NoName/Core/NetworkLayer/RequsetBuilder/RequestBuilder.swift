//
//  RequestBuilder.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

enum HTTPSMethod: String {
    case get
}

enum BaseUrl: String {
    case gitHub = "https://api.github.com"
}

final class RequestBuilder {
    
    private let baseUrl: BaseUrl
    private var method: HTTPSMethod = .get
    private var path: String?
    private var parametres: [String: String] = [:]
    
    init(base: BaseUrl = .gitHub,
         method: HTTPSMethod = .get,
         path: String? = nil) {
        self.baseUrl = base
        self.method = method
        self.path = path
    }
    
    func baseRequest(base: BaseUrl) -> RequestBuilder {
        .init(base: base)
    }
    
}

extension RequestBuilder: RequestBuilderProtocol {
    
    func setParametres(_ parametres: [String : String]) -> Self {
        self.parametres = parametres
        return self
    }
    
    func setMethod(_ method: HTTPSMethod) -> Self {
        self.method = method
        return self
    }
    
    func setPath(_ path: String) -> Self {
        self.path = path
        return self
    }
    
    func build() throws -> URLRequest {
        guard var urlComponents = URLComponents(string: [baseUrl.rawValue,
                                                         path]
            .compactMap { $0 }
            .joined()) else {
            throw NetworkError.cantBuildUrl
        }
        
        urlComponents.setQueryItems(with: parametres)
        
        guard let url = urlComponents.url else {
            throw NetworkError.cantBuildUrl
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
    
}

private extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        queryItems = parameters.map { URLQueryItem(name: $0.key,
                                                   value: $0.value) }
    }
    
}
