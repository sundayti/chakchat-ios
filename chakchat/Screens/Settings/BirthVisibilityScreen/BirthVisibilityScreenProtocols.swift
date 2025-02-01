//
//  BirthVisibilityScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation

// MARK: - BirthVisibilityScreenBusinessLogic
protocol BirthVisibilityScreenBusinessLogic {
    func backToConfidentialityScreen()
    
    func loadUserData()
    func showUserData(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility)
    func saveNewData(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility)
}

// MARK: - BirthVisibilityScreenPresentationLogic
protocol BirthVisibilityScreenPresentationLogic {
    func showUserData(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility)
}

// MARK: - BirthVisibilityScreenWorkerLogic
protocol BirthVisibilityScreenWorkerLogic {
    func saveNewBirthVisibilityOption(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility)
}
