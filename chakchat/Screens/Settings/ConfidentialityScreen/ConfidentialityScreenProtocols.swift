//
//  ConfidentialityScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation

// MARK: - ConfidentialityScreenBusinessLogic
protocol ConfidentialityScreenBusinessLogic {
    func loadUserData()
    func showUserData(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData)
    func showOnlineRestriction(_ onlineRestriction: OnlineVisibilityStatus)
    func showNewUserData(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData)
    func showNewOnlineRestriction(_ onlineRestriction: OnlineVisibilityStatus)
    
    func handleRestrictionsUpdate(_ event: UpdateRestrictionsEvent)
    
    func backToSettingsMenu()
    func routeToPhoneVisibilityScreen()
    func routeToBirthVisibilityScreen()
    func routeToOnlineVisibilityScreen()
    func routeToBlackListScreen()
}

// MARK: - ConfidentialityScreenPresentationLogic
protocol ConfidentialityScreenPresentationLogic {
    func showUserData(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData)
    func showOnlineRestriction(_ onlineRestriction: OnlineVisibilityStatus)
    func showNewUserData(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData)
    func showNewOnlineRestriction(_ onlineRestriction: OnlineVisibilityStatus)
}

// MARK: - ConfidentialityScreenWorkerLogic
protocol ConfidentialityScreenWorkerLogic {
    func getUserData(completion: @escaping (Result<ConfidentialitySettingsModels.ConfidentialityUserData, Error>) -> Void)
}
