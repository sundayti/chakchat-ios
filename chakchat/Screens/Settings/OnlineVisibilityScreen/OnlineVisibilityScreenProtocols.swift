//
//  OnlineVisibilityScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation

// MARK: - OnlineVisibilityScreenBusinessLogic
protocol OnlineVisibilityScreenBusinessLogic {
    func backToConfidentialityScreen(_ onlineRestriction: String)
    
    func loadUserRestrictions()
    func showUserRestrictions(_ onlineRestriction: OnlineVisibilityStatus)
    func saveNewRestrictions(_ onlineRestriction: OnlineVisibilityStatus)
}

// MARK: - OnlineVisibilityScreenPresentationsLogic
protocol OnlineVisibilityScreenPresentationLogic {
    func showUserRestrictions(_ onlineRestriction: OnlineVisibilityStatus)
}

// MARK: - OnlineVisibilityScreenWorkerLogic
protocol OnlineVisibilityScreenWorkerLogic {
    func saveNewRestrictions(_ newOnlineRestriction: OnlineVisibilityStatus)
}
