//
//  PairLabelView.swift
//
//  Created by Dmitry Kosyakov on 18.12.2022.
//

import UIKit

final class PairLabelView: BaseView {
    
    private let titleLabel = UILabel()
    private let subTitleLable = UILabel()
    
    private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLable])
        .disableTranslatesAutoresizingMask()
    
    
    override func setupUI() {
        addSubview(stackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func titleLabelConfiguration(configuration: (UILabel) -> Void) -> Self {
        configuration(titleLabel)
        return self
    }
    
    func subtitleLabelConfiguration(configuration: (UILabel) -> Void) -> Self {
        configuration(subTitleLable)
        return self
    }
    
    func stackViewConfiguration(configuration: (UIStackView) -> Void) -> Self {
        configuration(stackView)
        return self
    }
    
    func setTitle(_ text: String?) {
        titleLabel.text = text
    }
    
    func setSubtitle(_ text: String?) {
        subTitleLable.text = text
    }
    
}
