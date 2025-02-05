//
//  NotificationScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation

// MARK: - NotificationScreenBusinessLogic
protocol NotificationScreenBusinessLogic {
    func backToSettingsMenu()
    
    func loadUserData()
    func showUserData(_ userData: NotificationScreenModels.NotificationStatus)
    func saveNewData(_ userData: NotificationScreenModels.NotificationStatus)
    func updateNotififcationSettings(at indexPath: IndexPath, isOn: Bool)
}

// MARK: - NotificationScreenPresentationLogic
protocol NotificationScreenPresentationLogic {
    func showUserData(_ userData: NotificationScreenModels.NotificationStatus)
}

// MARK: - NotificationScreenWorkerLogic
protocol NotificationScreenWorkerLogic {
    func saveNewData(_ userData: NotificationScreenModels.NotificationStatus)
}
