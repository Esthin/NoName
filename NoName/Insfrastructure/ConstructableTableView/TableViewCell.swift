//
//  TableViewCell.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

final class TableViewCell<T: ConstructableView>: UITableViewCell,
                                                 ConstructableCell {
    
    typealias Content = T
    
    lazy var content = Content()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        content.prepareForReuse()
    }
    
    func commonInit() {
        selectionStyle = .none
        content.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(content)
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: contentView.topAnchor),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(data: T.DataType) {
        content.configure(data: data)
    }
    
}
