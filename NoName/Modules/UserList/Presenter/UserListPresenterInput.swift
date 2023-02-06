//
//  UserListPresenterInput.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

protocol UserListPresenterInput: ViewControllerLifeCycle,
                                 AnyObject {
    var view: UserListPresenterOutput? { get set }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    func didPullToRefresh()
    
}
