//
//  ImageDownloadOperationService.swift

//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

final class ImageDownloadOperationService {
    
    private var operations: [ImageDownloadOperation] = []
    private let queue = DispatchQueue(label: "imageOperationsService", attributes: .concurrent)
    
}

extension ImageDownloadOperationService: ImageDownloadOperationServiceProtocol {
    
    func first(with url: URL) -> ImageDownloadOperation? {
        var operation: ImageDownloadOperation?
        queue.sync {
            operation = self.operations.first { $0.url == url }
        }
        return operation
    }
    
    func append(_ operation: ImageDownloadOperation) {
        queue.async(flags: .barrier) {
            self.operations.append(operation)
        }
    }
    
    func removeWhere(url: URL) {
        queue.async(flags: .barrier) {
            self.operations.removeAll(where: { $0.url == url })
        }
    }
    
}
