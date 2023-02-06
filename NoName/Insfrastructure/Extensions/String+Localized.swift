//
//  String+Localized.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
}
