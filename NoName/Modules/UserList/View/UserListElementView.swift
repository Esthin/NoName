//
//  UserListElementView.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

typealias UserElementCellConstructor = TableCellConstructor<TableViewCell<UserListElementView>, UserListElementViewModel>

final class UserListElementView: BaseView,
                                 ConstructableView {
    
    private var onReuse: (() -> Void)?
    
    private lazy var stackView = UIStackView(arrangedSubviews: [avatarImageView,
                                                                textStackView])
        .disableTranslatesAutoresizingMask()
        .axis(.horizontal)
        .distribution(.fill)
        .alignment(.center)
        .spacing(8)
    
    private lazy var textStackView = UIStackView(arrangedSubviews: [loginLabel,
                                                                    identifierLabel])
        .axis(.vertical)
        .distribution(.fill)
        .alignment(.leading)
        .spacing(8)
    
    private let avatarImageView = UIImageView()
        .clipToBounds(true)
        .cornerRadius(32)
        .alpha(0)
    
    private let loginLabel = UILabel()
        .font(.systemFont(ofSize: 17, weight: .bold))
    
    private let identifierLabel = UILabel()
        .font(.systemFont(ofSize: 14, weight: .regular))
        .textColor(.lightGray)
        
    override func setupUI() {
        addSubview(stackView)
        
        loginLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        identifierLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        setupConstraints()
    }

    func configure(data: UserListElementViewModel) {
        loginLabel.text = data.name
        identifierLabel.text = data.idDescription
        URL(string: data.avatarUrl).map { url in
            onReuse = {
                data.onReuse(url)
            }
            data.onGetImage(url) { [weak avatarImageView] image in
                avatarImageView?.image = image
                UIView.animate(withDuration: 0.3) {
                    avatarImageView?.alpha = 1
                }
            }
        }
    }
    
    func prepareForReuse() {
        avatarImageView.image = nil
        onReuse?()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 64),
            avatarImageView.widthAnchor.constraint(equalToConstant: 64),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
}
