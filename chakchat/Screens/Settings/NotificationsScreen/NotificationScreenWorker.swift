//
//  NotificationScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation

// MARK: - NotificationScreenWorker
final class NotificationScreenWorker: NotificationScreenWorkerLogic {
        
    // MARK: - Properties
    let userDefaultsManager: UserDefaultsManagerProtocol
    
    // MARK: - Initialization
    init(userDefaultsManager: UserDefaultsManagerProtocol) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    // MARK: - Public Methods
    func saveNewData(_ userData: NotificationScreenModels.NotificationStatus) {
        userDefaultsManager.saveGeneralNotificationStatus(userData.generalNotification)
        userDefaultsManager.saveAudioNotificationStatus(userData.audioNotification)
        userDefaultsManager.saveVibrationNotificationStatus(userData.vibrationNotification)
    }
}
