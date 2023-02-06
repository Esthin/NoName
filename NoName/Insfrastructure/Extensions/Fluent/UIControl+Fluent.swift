//
//  UIControl+Fluent.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

extension UIControl {
    
    func setTarget(_ target: Any?, action: Selector, for event: UIControl.Event) -> Self {
        addTarget(target, action: action, for: event)
        return self
    }
    
}
