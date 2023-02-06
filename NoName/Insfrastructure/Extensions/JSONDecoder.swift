//
//  JSONDecoder.swift
//
//  Created by Dmitry Kosyakov on 18.12.2022.
//

import Foundation

extension JSONDecoder {
    
    func setStrategy(_ strategy: JSONDecoder.DateDecodingStrategy) -> Self {
        dateDecodingStrategy = strategy
        return self
    }
    
}
