//
//  UIIMageView+Fluent.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

extension UIImageView {
    
    func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
    
}
