//
//  ConfidentialityScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation

// MARK: - ConfidentialityScreen Protocols
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

protocol ConfidentialityScreenPresentationLogic {
    func showUserData(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData)
    func showOnlineRestriction(_ onlineRestriction: OnlineVisibilityStatus)
    func showNewUserData(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData)
    func showNewOnlineRestriction(_ onlineRestriction: OnlineVisibilityStatus)
}

protocol ConfidentialityScreenWorkerLogic {
    func getUserData(completion: @escaping (Result<ConfidentialitySettingsModels.ConfidentialityUserData, Error>) -> Void)
}
