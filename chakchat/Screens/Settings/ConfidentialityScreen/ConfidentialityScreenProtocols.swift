//
//  ConfidentialityScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
protocol ConfidentialityScreenBusinessLogic {
    func loadUserData()
    func showUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData)
    func saveNewUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData)
    func backToSettingsMenu()
}
protocol ConfidentialityScreenPresentationLogic {
    func showUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData)
}
protocol ConfidentialityScreenWorkerLogic {
    func saveNewData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData)
}
