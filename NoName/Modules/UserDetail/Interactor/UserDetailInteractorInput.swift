//
//  UserDetailInteractorInput.swift
//
//  Created by Dmitry Kosyakov on 17.12.2022.
//

import Foundation

protocol UserDetailInteractorInput: AnyObject {
    var imageLoadingService: ImageLoadingServiceProtocol { get }
    func attach(_ output: UserDetailInteractorOutput)
    func fetchData()
    
}
