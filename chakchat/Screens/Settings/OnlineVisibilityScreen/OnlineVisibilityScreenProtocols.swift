//
//  OnlineVisibilityScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation

// MARK: - OnlineVisibilityScreenBusinessLogic
protocol OnlineVisibilityScreenBusinessLogic {
    func backToConfidentialityScreen()
    
    func loadUserData()
    func showUserData(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility)
    func saveNewData(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility)
}

// MARK: - OnlineVisibilityScreenPresentationLogic
protocol OnlineVisibilityScreenPresentationLogic {
    func showUserData(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility)
}

// MARK: - OnlineVisibilityScreenWorkerLogic
protocol OnlineVisibilityScreenWorkerLogic {
    func saveNewOnlineVisibilityOption(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility)
}
