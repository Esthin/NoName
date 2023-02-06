//
//  LoadingView.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

final class LoadingView: UIView {
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
        .disableTranslatesAutoresizingMask()
        .color(.white)
    
    private let contentView = UIView()
        .disableTranslatesAutoresizingMask()
        .cornerRadius(12)
        .backgroundColor(.gray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        isHidden = true
        addSubview(contentView)
        contentView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 64),
            contentView.widthAnchor.constraint(equalToConstant: 64),
            
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func showLoader() {
        superview?.bringSubviewToFront(self)
        isUserInteractionEnabled = false
        isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        isUserInteractionEnabled = true
        isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func setupForView(_ view: UIView) -> Self {
        view.addSubview(self)
        setupConstraint(for: view)
        return self
    }
    
    private func setupConstraint(for view: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
