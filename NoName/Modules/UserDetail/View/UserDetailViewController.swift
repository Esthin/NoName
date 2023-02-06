//
//  UserDetailViewController.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

final class UserDetailViewController: UIViewController {
    
    private lazy var loadingView = LoadingView()
        .disableTranslatesAutoresizingMask()
        .setupForView(view)
    
    var presenter: UserDetailPresenterInput!
    
    lazy var tableView = ConstructableTableView()
        .disableTranslatesAutoresizingMask()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        tableView.registerConstructor([UserRepositoryCellConstructor.self,
                                       UserDetailCellConstructor.self])
        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension UserDetailViewController: UserDetailPresenterOutput {
    
    func showLoader() {
        loadingView.showLoader()
    }
    
    func hideLoader() {
        loadingView.hideLoader()
    }
    
}

extension UserDetailViewController: ConstructableTableViewContainer {
    
}
