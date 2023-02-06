//
//  UIViewController+Alert.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

protocol Routable {
    func push(_ viewController: UIViewController, animated: Bool)
    func push(_ viewController: UIViewController)
    func pop(animated: Bool)
    func pop()
    func showAlert(title: String?,
                   message: String?,
                   actions: [UIAlertAction])
}

extension Routable {
    
    func push(_ viewController: UIViewController) {
        push(viewController, animated: true)
    }
    
    func pop() {
        pop(animated: true)
    }
    
}

extension Routable where Self: BaseRouter {
    
    func showAlert(title: String?,
                   message: String?,
                   actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        actions.forEach(alert.addAction(_:))
        viewController?.present(alert, animated: true)
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        assert(self.viewController?.navigationController != nil)
        self.viewController?.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        viewController?.navigationController?.popViewController(animated: animated)
    }
    
}
