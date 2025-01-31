//
//  NotificationScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation
protocol NotificationScreenBusinessLogic {
    func backToSettingsMenu()
    
    func loadUserData()
    func showUserData(_ userData: NotificationScreenModels.NotificationStatus)
    func saveNewData(_ userData: NotificationScreenModels.NotificationStatus)
    
}
protocol NotificationScreenPresentationLogic {
    func showUserData(_ userData: NotificationScreenModels.NotificationStatus)
}
protocol NotificationScreenWorkerLogic {
    func saveNewData(_ userData: NotificationScreenModels.NotificationStatus)
}
