//
//  ImageLoadingService.swift

//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

final class ImageLoadingService {

    private let cacheService: ImageCacheServiceProtocol
    private let taskFactory: DataTaskFactoryProtocol
    private let operationService: ImageDownloadOperationServiceProtocol
    private let queue = DispatchQueue(label: "imageLoader")
    
    init(taskFactory: DataTaskFactoryProtocol = DataTaskFactory(),
         cacheService: ImageCacheServiceProtocol = ImageCacheService(),
         operationService: ImageDownloadOperationServiceProtocol = ImageDownloadOperationService()) {
        self.taskFactory = taskFactory
        self.cacheService = cacheService
        self.operationService = operationService
    }
    
}

extension ImageLoadingService: ImageLoadingServiceProtocol {
    
    func cancel(url: URL) {
        queue.async {
            guard let operation = self.operationService.first(with: url) else {
                return
            }
            operation.dataTask?.cancel()
            self.operationService.removeWhere(url: url)
        }
    }
    
    func loadImage(with url: URL,
                   resultOn: DispatchQueue,
                   completion: @escaping (Result<UIImage, Error>) -> Void) {
        queue.async {
            if let operation = self.operationService.first(with: url) {
                operation.add(completion: completion)
                return
            }
            
            if let cachedImage = self.cacheService.getImage(for: url.absoluteString) {
                resultOn.async {
                    completion(.success(cachedImage))
                }
                return
            }
            
            let operation = ImageDownloadOperation(url: url)
            operation.add(completion: completion)
            self.operationService.append(operation)
            let dataTask = self.taskFactory.dataTask(type: .url(url))  { [weak self] data, _, error in
                guard let self = self else { return }
                resultOn.async {
                    if let image = data.flatMap(UIImage.init(data:)) {
                        self.cacheService.setImage(image, for: url.absoluteString)
                        operation.runCompletions(result: .success(image))
                    } else if let error = error {
                        operation.runCompletions(result: .failure(error))
                    } else {
                        operation.runCompletions(result: .failure(NetworkError.unknown))
                    }
                }
                self.operationService.removeWhere(url: url)
            }
            operation.dataTask = dataTask
            dataTask.resume()
        }
    }
    
}
