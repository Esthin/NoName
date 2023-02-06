//
//  UILabel+Fluent.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

extension UILabel {
    
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    func textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    func numberOfLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
    
}
