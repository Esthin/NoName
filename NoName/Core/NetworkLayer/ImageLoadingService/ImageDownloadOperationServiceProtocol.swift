//
//  ImageDownloadOperationServiceProtocol.swift

//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol ImageDownloadOperationServiceProtocol {
    func first(with url: URL) -> ImageDownloadOperation?
    func append(_ operation: ImageDownloadOperation)
    func removeWhere(url: URL)
}
