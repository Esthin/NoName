//
//  UIStackView+Fluent.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

extension UIStackView {
    
    func axis(_ axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        return self
    }
    
    func alignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }
    
    func distribution(_ distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }
    
    func spacing(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }
    
    func layoutMargins(_ insets: UIEdgeInsets) -> Self {
        self.layoutMargins = insets
        return self
    }
    
    func isLayoutMarginsRelativeArrangement(_ isLayoutMarginsRelativeArrangement: Bool) -> Self {
        self.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        return self
    }
    
}
