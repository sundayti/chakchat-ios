//
//  BirthVisibilityScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
final class BirthVisibilityScreenWorker: BirthVisibilityScreenWorkerLogic {
    
    let userDeafultsManager: UserDefaultsManagerProtocol
    
    init(userDeafultsManager: UserDefaultsManagerProtocol) {
        self.userDeafultsManager = userDeafultsManager
    }
    
    func saveNewBirthVisibilityOption(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility) {
        userDeafultsManager.saveConfidentialityDateOfBirthStatus(birthVisibility.birthStatus.rawValue)
    }
}
