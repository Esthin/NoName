//
//  UserInfoView.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

typealias UserDetailCellConstructor = TableCellConstructor<TableViewCell<UserDetailView>, UserDetailViewModel>

final class UserDetailView: BaseView,
                            ConstructableView {
    
    private lazy var stackView = UIStackView(arrangedSubviews: [imageView,
                                                                textStackView])
        .disableTranslatesAutoresizingMask()
        .axis(.vertical)
        .spacing(8)
        .distribution(.fill)
        .alignment(.leading)
    
    private lazy var textStackView = UIStackView(arrangedSubviews: [loginLabel,
                                                                   nameLabel,
                                                                   dateLabel])
        .disableTranslatesAutoresizingMask()
        .axis(.vertical)
        .spacing(8)
        .distribution(.fill)
        .alignment(.leading)
    
    private let imageView = UIImageView()
        .contentMode(.scaleToFill)
        .clipToBounds(true)
        .cornerRadius(16)
    
    private let nameLabel = UILabel()
        .font(.systemFont(ofSize: 20, weight: .regular))
    
    private let loginLabel = UILabel()
        .font(.systemFont(ofSize: 26, weight: .bold))
    
    private let dateLabel = UILabel()
        .font(.systemFont(ofSize: 20, weight: .regular))
    
    override func setupUI() {
        addSubview(stackView)
        loginLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        dateLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        setupConstraints()
    }
    
    func configure(data: UserDetailViewModel) {
        loginLabel.text = data.userLogin
        nameLabel.text = data.userName
        dateLabel.text = data.userRegisterString
        URL(string: data.avatarUrlString).map { url in
            data.onGetImage(url) { [weak imageView] image in
                imageView?.image = image
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
}
