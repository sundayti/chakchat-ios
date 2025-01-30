//
//  PhoneVisibilityScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
protocol PhoneVisibilityScreenBusinessLogic {
    func backToConfidentialityScreen()
    
    func loadUserData()
    func showUserData(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility)
    func saveNewData(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility)
    
    
}
protocol PhoneVisibilityScreenPresentationLogic {
    func showUserData(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility)
}
protocol PhoneVisibilityScreenWorkerLogic {
    func saveNewPhoneVisibilityOption(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility)
}
