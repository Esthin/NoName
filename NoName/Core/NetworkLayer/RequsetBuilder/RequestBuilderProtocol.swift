//
//  RequestBuilderProtocol.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol RequestBuilderProtocol: AnyObject {
    func baseRequest(base: BaseUrl) -> RequestBuilder
    func build() throws -> URLRequest
    func setMethod(_ method: HTTPSMethod) -> Self
    func setPath(_ path: String) -> Self
    func setParametres(_ parametres: [String: String]) -> Self
}
