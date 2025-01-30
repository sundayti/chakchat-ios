//
//  PhoneVisibilityScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
final class PhoneVisibilityScreenWorker: PhoneVisibilityScreenWorkerLogic {
    
    let userDefaultsManager: UserDefaultsManagerProtocol
    
    init(userDefaultsManager: UserDefaultsManagerProtocol) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func saveNewPhoneVisibilityOption(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility) {
        userDefaultsManager.saveConfidentialityPhoneStatus(phoneVisibility.phoneStatus.rawValue)
    }
}
