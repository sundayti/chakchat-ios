//
//  OnlineVisibilityScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation

// MARK: - OnlineVisibilityScreenWorker
final class OnlineVisibilityScreenWorker: OnlineVisibilityScreenWorkerLogic {
    
    // MARK: - Properties
    let userDeafultsManager: UserDefaultsManagerProtocol
    
    // MARK: - Initialization
    init(userDeafultsManager: UserDefaultsManagerProtocol) {
        self.userDeafultsManager = userDeafultsManager
    }
    
    func saveNewRestrictions(_ newOnlineRestriction: OnlineVisibilityStatus) {
        userDeafultsManager.saveOnlineStatus(newOnlineRestriction.status)
    }
}
