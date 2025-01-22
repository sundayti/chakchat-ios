//
//  UserDefaultsService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 22.01.2025.
//

import Foundation
import UIKit

class UserDefaultsService {
    let avatarKey = "iconImage"

    func saveAvatar(image: UIImage, compressionQuality: CGFloat = 0.8) {
        guard let imageData = image.jpegData(compressionQuality: compressionQuality) else {
            print("Error: can't save the icon")
            return
        }
        UserDefaults.standard.set(imageData, forKey: avatarKey)
    }

    func loadAvatar() -> UIImage? {
        guard let imageData = UserDefaults.standard.data(forKey: avatarKey) else {
            return nil
        }
        return UIImage(data: imageData)
    }

    func deleteAvatar() {
        UserDefaults.standard.removeObject(forKey: avatarKey)
    }
}
