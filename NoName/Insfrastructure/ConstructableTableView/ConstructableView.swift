//
//  ConstructableView.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

protocol ConstructableView where Self: UIView {
    associatedtype DataType
    func configure(data: DataType)
    func prepareForReuse()
}

extension ConstructableView {
    
    func prepareForReuse() {}
    
}

