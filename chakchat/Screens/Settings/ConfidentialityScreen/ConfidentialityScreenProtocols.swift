//
//  ConfidentialityScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
protocol ConfidentialityScreenBusinessLogic {
    func loadUserData()
    func updateUserData()
    func showUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData)
    func showNewUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData)
    
    func handlePhoneVisibilityChangeEvent(_ event: UpdatePhoneStatusEvent)
    func handleBirthVisibilityChangeEvent(_ event: UpdateBirthStatusEvent)
    func handleOnlineVisibilityChangeEvent(_ event: UpdateOnlineStatusEvent)
    
    func backToSettingsMenu()
    func routeToPhoneVisibilityScreen()
    func routeToBirthVisibilityScreen()
    func routeToOnlineVisibilityScreen()
}
protocol ConfidentialityScreenPresentationLogic {
    func showUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData)
    func showNewUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData)
}
protocol ConfidentialityScreenWorkerLogic {
}
