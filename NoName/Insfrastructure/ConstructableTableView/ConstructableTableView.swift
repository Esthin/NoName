//
//  ConstructableTableView.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

final class ConstructableTableView: UITableView {
    
    private var scrollViewDidEndDragging: ((UIScrollView, Bool) -> Void)?
    private var scrollViewDidEndDecelerating: ((UIScrollView) -> Void)?
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        separatorStyle = .none
        dataSource = self
        delegate = self
        prefetchDataSource = self
    }
    
    private var data: [CellConstructor] = []
    
    func registerConstructor(_ constructor: [CellConstructor.Type]) {
        constructor
            .map { ($0.cellType, $0.reuseId) }
            .forEach {
                register($0, forCellReuseIdentifier: $1)
            }
    }
    
    func updateData(_ data: [CellConstructor]) {
        self.data = data
        reloadData()
    }
    
}

extension ConstructableTableView: UITableViewDataSource,
                                  UITableViewDelegate,
                                  UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView,
                   prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.map { data[$0.row] }.forEach { $0.onPrefetch?() }
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: type(of: data[indexPath.row]).reuseId) else {
            assertionFailure()
            return UITableViewCell()
        }
        data[indexPath.row].configure(cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        data[indexPath.row].onTap?()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollViewDidEndDragging?(scrollView, decelerate)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating?(scrollView)
    }
    
}

extension ConstructableTableView {
    
    func onScrollViewDidEndDecelerating(_ action: @escaping ((UIScrollView) -> Void)) -> Self {
        scrollViewDidEndDecelerating = action
        return self
    }
    
    func onScrollViewDidEndDragging(_ action: @escaping ((UIScrollView, Bool) -> Void)) -> Self {
        scrollViewDidEndDragging = action
        return self
    }
    
    func refreshControl(_ refreshControl: UIRefreshControl) -> Self {
        self.refreshControl = refreshControl
        return self
    }
    
}
