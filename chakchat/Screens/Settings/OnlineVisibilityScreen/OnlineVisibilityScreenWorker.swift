//
//  OnlineVisibilityScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation
final class OnlineVisibilityScreenWorker: OnlineVisibilityScreenWorkerLogic {
    
    let userDeafultsManager: UserDefaultsManagerProtocol
    
    init(userDeafultsManager: UserDefaultsManagerProtocol) {
        self.userDeafultsManager = userDeafultsManager
    }
    
    func saveNewOnlineVisibilityOption(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility) {
        userDeafultsManager.saveConfidentialityOnlineStatus(onlineVisibility.onlineStatus.rawValue)
    }
}
