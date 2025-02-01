//
//  PhoneVisibilityScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation

// MARK: - PhoneVisibilityScreenWorker
final class PhoneVisibilityScreenWorker: PhoneVisibilityScreenWorkerLogic {
    
    // MARK: - Properties
    let userDefaultsManager: UserDefaultsManagerProtocol
    
    // MARK: - Initialization
    init(userDefaultsManager: UserDefaultsManagerProtocol) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    // MARK: - New Phone Visibility Option Saving
    func saveNewPhoneVisibilityOption(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility) {
        userDefaultsManager.saveConfidentialityPhoneStatus(phoneVisibility.phoneStatus.rawValue)
    }
}
