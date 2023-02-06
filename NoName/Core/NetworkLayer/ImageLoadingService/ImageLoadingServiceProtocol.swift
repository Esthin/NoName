//
//  ImageLoadingServiceProtocol.swift

//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

protocol ImageLoadingServiceProtocol: AnyObject {
    func cancel(url: URL)
    func loadImage(with url: URL,
                   resultOn: DispatchQueue,
                   completion: @escaping (Result<UIImage, Error>) -> Void)
    func loadImage(with url: URL,
                   completion: @escaping (Result<UIImage, Error>) -> Void)
}

extension ImageLoadingServiceProtocol {
    
    func loadImage(with url: URL,
                   completion: @escaping (Result<UIImage, Error>) -> Void) {
        loadImage(with: url,
                  resultOn: .main,
                  completion: completion)
    }
    
}
