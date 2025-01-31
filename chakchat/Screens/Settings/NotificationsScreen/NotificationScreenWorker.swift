//
//  NotificationScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation

final class NotificationScreenWorker: NotificationScreenWorkerLogic {
        
    let userDefaultsManager: UserDefaultsManagerProtocol
    
    init(userDefaultsManager: UserDefaultsManagerProtocol) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func saveNewData(_ userData: NotificationScreenModels.NotificationStatus) {
        userDefaultsManager.saveGeneralNotificationStatus(userData.generalNotification)
        userDefaultsManager.saveAudioNotificationStatus(userData.audioNotification)
        userDefaultsManager.saveVibrationNotificationStatus(userData.vibrationNotification)
    }
}
