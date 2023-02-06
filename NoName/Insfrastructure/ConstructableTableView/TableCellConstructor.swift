//
//  TableCellConstructor.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

final class TableCellConstructor<CellType: ConstructableCell,
                                 DataType>: CellConstructor where CellType.DataType == DataType,
                                                                  CellType: UITableViewCell {
    
    static var reuseId: String {
        String(describing: CellType.self)
    }
    
    static var cellType: AnyClass {
        CellType.self
    }
    
    let item: DataType
    
    var onTap: (() -> Void)?
    
    var onPrefetch: (() -> Void)?
    
    init(item: DataType) {
        self.item = item
    }
    
    func configure(cell: UIView) {
        (cell as? CellType)?.configure(data: item)
    }
    
    func onTap(_ action: @escaping (() -> Void)) -> Self {
        onTap = action
        return self
    }
    
    func onPrefetch(_ action: @escaping (() -> Void)) -> Self {
        onPrefetch = action
        return self
    }
    
}
