//
//  ImageDownloadOperation.swift

//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

final class ImageDownloadOperation {
    
    let url: URL
    private var completions: [(Result<UIImage, Error>) -> Void] = []
    var dataTask: URLSessionDataTask?
    
    init(url: URL) {
        self.url = url
    }
    
    func add(completion: @escaping (Result<UIImage, Error>) -> Void ) {
        completions.append(completion)
    }
    
    func runCompletions(result: Result<UIImage, Error>) {
        completions.forEach { $0(result) }
    }
    
}
