//
//  CellConstructor.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

protocol CellConstructor {
    static var reuseId: String { get }
    static var cellType: AnyClass { get }
    
    var onTap: (() -> Void)? { get }
    var onPrefetch: (() -> Void)? { get }
    
    func configure(cell: UIView)
    func onTap(_ action: @escaping (() -> Void)) -> Self
}
