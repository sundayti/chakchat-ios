//
//  ImageCacheProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.02.2025.
//

import UIKit

// MARK: - ImageCacheProtocol
protocol ImageCacheProtocol {
    
    func getImage(for url: NSURL) -> UIImage?

    func saveImage(_ image: UIImage, for url: NSURL)
}
