//
//  BirthVisibilityScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
protocol BirthVisibilityScreenBusinessLogic {
    func backToConfidentialityScreen()
    
    func loadUserData()
    func showUserData(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility)
    func saveNewData(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility)
    
    
}
protocol BirthVisibilityScreenPresentationLogic {
    func showUserData(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility)
}
protocol BirthVisibilityScreenWorkerLogic {
    func saveNewBirthVisibilityOption(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility)
}
