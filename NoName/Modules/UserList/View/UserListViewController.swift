//
//  UserListViewController.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

final class UserListViewController: UIViewController {
    
    var presenter: UserListPresenterInput!
    
    lazy var tableView = ConstructableTableView()
        .disableTranslatesAutoresizingMask()
        .refreshControl(refreshControl)
        .onScrollViewDidEndDragging { [weak presenter] scrollView, decelerate in
            presenter?.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
        }
        .onScrollViewDidEndDecelerating { [weak presenter] scrollView in
            presenter?.scrollViewDidEndDecelerating(scrollView)
        }
    
    private lazy var refreshControl = UIRefreshControl()
        .setTarget(self,
                   action: #selector(didPullToRefresh),
                   for: .valueChanged)
    
    private lazy var loadingView = LoadingView()
        .disableTranslatesAutoresizingMask()
        .setupForView(view)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    @objc
    private func didPullToRefresh() {
        presenter.didPullToRefresh()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "GitHub users".localized
        view.addSubview(tableView)
        tableView.registerConstructor([UserElementCellConstructor.self])
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

extension UserListViewController: UserListPresenterOutput {
    func showLoader() {
        loadingView.showLoader()
    }
    
    func hideLoader() {
        loadingView.hideLoader()
        refreshControl.endRefreshing()
    }
    
}

extension UserListViewController: ConstructableTableViewContainer {
    
}



