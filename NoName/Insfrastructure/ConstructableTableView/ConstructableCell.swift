//
//  ConstructableCell.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol ConstructableCell {
    associatedtype DataType
    func configure(data: DataType)
}
