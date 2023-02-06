//
//  ImageCacheService.swift

//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

final class ImageCacheService {
    
    private let imageCache = NSCache<NSString, UIImage>()
    
}

extension ImageCacheService: ImageCacheServiceProtocol {
    
    func getImage(for key: String) -> UIImage? {
        imageCache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, for key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    
}
