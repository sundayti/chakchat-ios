//
//  ImageCacheManager.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.02.2025.
//

import UIKit

final class ImageCacheManager: ImageCacheProtocol {
    
    static let shared = ImageCacheManager()
    
    private init() {}
    
    private let cache = NSCache<NSURL, UIImage>()
    
    func getImage(for url: NSURL) -> UIImage? {
        return cache.object(forKey: url)
    }
    
    func saveImage(_ image: UIImage, for url: NSURL) {
        cache.setObject(image, forKey: url)
    }
}
