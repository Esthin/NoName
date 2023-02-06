//
//  UIView+Fluent.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

extension UIView {
    
    func disableTranslatesAutoresizingMask() -> Self {
        translatesAutoresizingMaskIntoConstraints  = false
        return self
    }
    
    func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    func clipToBounds(_ clipToBounds: Bool) -> Self {
        self.clipsToBounds = clipToBounds
        return self
    }
    
    func cornerRadius(_ cornerRadius: CGFloat) -> Self {
        layer.cornerRadius = cornerRadius
        return self
    }
    
    func backgroundColor(_ backgroundColor: UIColor) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }
    
}
