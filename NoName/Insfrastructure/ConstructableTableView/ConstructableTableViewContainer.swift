//
//  ConstructableTableViewContainer.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

protocol ConstructableTableViewContainer {
    var tableView: ConstructableTableView { get }
}

protocol ConstrucatableTableViewInput: AnyObject {
    func reloadData(with: [CellConstructor])
}

extension ConstrucatableTableViewInput where Self: ConstructableTableViewContainer {
    
    func reloadData(with cells: [CellConstructor]) {
        tableView.updateData(cells)
        tableView.reloadData()
    }
    
}

