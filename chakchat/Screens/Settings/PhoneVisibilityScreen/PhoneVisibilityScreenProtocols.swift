//
//  PhoneVisibilityScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation

// MARK: - PhoneVisibilityScreenBusinessLogic
protocol PhoneVisibilityScreenBusinessLogic {
    func backToConfidentialityScreen()
    
    func loadUserData()
    func showUserData(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility)
    func saveNewData(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility)
}

// MARK: - PhoneVisibilityScreenPresentationLogic
protocol PhoneVisibilityScreenPresentationLogic {
    func showUserData(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility)
}

// MARK: - PhoneVisibilityScreenWorkerLogic
protocol PhoneVisibilityScreenWorkerLogic {
    func saveNewPhoneVisibilityOption(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility)
}
