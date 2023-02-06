//
//  BasePresenter.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol ViewControllerLifeCycle {
    func viewDidLoad()
}

extension ViewControllerLifeCycle {
    
    func viewDidLoad() {
        assertionFailure("not implemented")
    }
    
}
