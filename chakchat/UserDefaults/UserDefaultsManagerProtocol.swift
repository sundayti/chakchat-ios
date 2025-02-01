//
//  UserDefaultsManagerProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import UIKit

// MARK: - UserDefaultsManagerProtocol
protocol UserDefaultsManagerProtocol {
    func saveAvatar(_ icon: UIImage)
    func saveNickname(_ nickname: String)
    func saveUsername(_ username: String)
    func savePhone(_ phone: String)
    func saveConfidentialityPhoneStatus(_ phoneStatus: String)
    func saveConfidentialityDateOfBirthStatus(_ birthStatus: String)
    func saveConfidentialityOnlineStatus(_ onlineStatus: String)
    
    func loadAvatar() -> UIImage?
    func loadNickname() -> String
    func loadUsername() -> String
    func loadPhone() -> String
    func loadConfidentialityPhoneStatus() -> String
    func loadConfidentialityDateOfBirthStatus() -> String
    func loadConfidentialityOnlineStatus() -> String
    
    func deleteAvatar()
}
