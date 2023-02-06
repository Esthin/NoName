//
//  Error+Debug.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

// TODO: - Its a joke.
extension Error {
    var description: String {
        #if DEBUG
        return self.localizedDescription
        #else
        return "Please try again".localized
        #endif
    }
}
