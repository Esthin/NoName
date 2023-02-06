//
//  CancellableTask.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol CancellableTask: AnyObject {
    func cancel()
    var isRunning: Bool { get }
}

extension URLSessionDataTask: CancellableTask {
    var isRunning: Bool {
        state == .running
    }
}
