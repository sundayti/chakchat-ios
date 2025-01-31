//
//  OnlineVisibilityScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation
protocol OnlineVisibilityScreenBusinessLogic {
    func backToConfidentialityScreen()
    
    func loadUserData()
    func showUserData(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility)
    func saveNewData(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility)
}
protocol OnlineVisibilityScreenPresentationLogic {
    func showUserData(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility)
}
protocol OnlineVisibilityScreenWorkerLogic {
    func saveNewOnlineVisibilityOption(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility)
}
