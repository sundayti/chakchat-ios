//
//  BirthVisibilityScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation

// MARK: - BirthVisibilityScreenWorker
final class BirthVisibilityScreenWorker: BirthVisibilityScreenWorkerLogic {
    
    // MARK: - Properties
    let userDeafultsManager: UserDefaultsManagerProtocol
    
    // MARK: - Initialization
    init(userDeafultsManager: UserDefaultsManagerProtocol) {
        self.userDeafultsManager = userDeafultsManager
    }
    
    // MARK: - New Birth Visibility Option Saving
    func saveNewBirthVisibilityOption(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility) {
        userDeafultsManager.saveConfidentialityDateOfBirthStatus(birthVisibility.birthStatus.rawValue)
    }
}
