//
//  UserRepositoryView.swift
//
//  Created by Dmitry Kosyakov on 18.12.2022.
//

import UIKit

typealias UserRepositoryCellConstructor = TableCellConstructor<TableViewCell<UserRepositoryView>, UserRepositoryViewModel>

final class UserRepositoryView: BaseView,
                                ConstructableView {
    
    private let repositoryInfoView = PairLabelView()
        .titleLabelConfiguration {
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
            $0.textColor = .black
        }
        .subtitleLabelConfiguration {
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
            $0.textColor = .gray
            $0.numberOfLines = 0
        }
        .stackViewConfiguration {
            $0.axis = .vertical
            $0.spacing = 4
            $0.alignment = .fill
            $0.distribution = .fill
        }
    
    private lazy var languagePairView = makeContentPairedLabel()
    private lazy var forksPairView = makeContentPairedLabel()
    private lazy var warcherPairView = makeContentPairedLabel()
    
    private let container = UIView()
        .disableTranslatesAutoresizingMask()
    
    private lazy var stackView = UIStackView(arrangedSubviews: [repositoryInfoView,
                                                                descriptionStackView])
        .disableTranslatesAutoresizingMask()
        .axis(.vertical)
        .alignment(.fill)
        .distribution(.fill)
        .spacing(4)
        .isLayoutMarginsRelativeArrangement(true)
        .layoutMargins(.init(top: 8, left: 16, bottom: 8, right: 16))
    
    private lazy var descriptionStackView = UIStackView(arrangedSubviews: [forksPairView,
                                                                           warcherPairView,
                                                                           languagePairView])
        .axis(.horizontal)
        .alignment(.center)
        .distribution(.fillEqually)
    
    private var shadowLayer: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        guard shadowLayer == nil || shadowLayer?.bounds != container.bounds  else { return }
        shadowLayer?.removeFromSuperlayer()
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: container.bounds, cornerRadius: 12).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0, height: 5)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 4
        self.shadowLayer = shadowLayer
        container.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    override func setupUI() {
        addSubview(container)
        container.addSubview(stackView)
        setupConstraints()
    }
    
    func configure(data: UserRepositoryViewModel) {
        repositoryInfoView.setTitle(data.name)
        repositoryInfoView.setSubtitle(data.description)
        forksPairView.setTitle(data.forksDescription)
        forksPairView.setSubtitle(data.forksCount)
        languagePairView.setTitle(data.language)
        warcherPairView.setTitle(data.watchersDescription)
        warcherPairView.setSubtitle(data.watchersCount)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            stackView.topAnchor.constraint(equalTo: container.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
    
    private func makeContentPairedLabel() -> PairLabelView {
        PairLabelView()
            .titleLabelConfiguration {
                $0.font = .systemFont(ofSize: 14, weight: .bold)
                $0.textColor = .black
                $0.setContentCompressionResistancePriority(.required, for: .vertical)
            }
            .subtitleLabelConfiguration {
                $0.font = .systemFont(ofSize: 12, weight: .regular)
                $0.textColor = .black
                $0.numberOfLines = 0
                $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
            }
            .stackViewConfiguration {
                $0.axis = .vertical
                $0.spacing = 4
                $0.alignment = .center
                $0.distribution = .fill
            }
    }
    
}
