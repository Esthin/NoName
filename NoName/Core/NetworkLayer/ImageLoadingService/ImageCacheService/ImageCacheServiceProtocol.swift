//
//  ImageCacheServiceProtocol.swift

//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import UIKit

protocol ImageCacheServiceProtocol {
    func getImage(for key: String) -> UIImage?
    func setImage(_ image: UIImage, for key: String)
}
