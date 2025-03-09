//
//  NotificationScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation

// MARK: - NotificationScreen Protocols
protocol NotificationScreenBusinessLogic {
    func backToSettingsMenu()
    
    func loadUserData()
    func showUserData(_ userData: NotificationScreenModels.NotificationStatus)
    func saveNewData(_ userData: NotificationScreenModels.NotificationStatus)
    func updateNotififcationSettings(at indexPath: IndexPath, isOn: Bool)
}

protocol NotificationScreenPresentationLogic {
    func showUserData(_ userData: NotificationScreenModels.NotificationStatus)
}

protocol NotificationScreenWorkerLogic {
    func saveNewData(_ userData: NotificationScreenModels.NotificationStatus)
}
