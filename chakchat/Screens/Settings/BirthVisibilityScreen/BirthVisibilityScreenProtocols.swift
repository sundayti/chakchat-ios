//
//  BirthVisibilityScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation

// MARK: - BirthVisibilityScreenBusinessLogic
protocol BirthVisibilityScreenBusinessLogic {
    /// тут все аналогично экрану PhoneVisibility
    func backToConfidentialityScreen(_ birthRestriction: String)
    
    func loadUserRestrictions()
    func showUserRestrictions(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData)
    func saveNewRestrictions(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData)
}

// MARK: - BirthVisibilityScreenPresentationLogic
protocol BirthVisibilityScreenPresentationLogic {
    func showUserRestrictions(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData)
}

// MARK: - BirthVisibilityScreenWorkerLogic
protocol BirthVisibilityScreenWorkerLogic {
    func updateUserRestriction(_ request: ConfidentialitySettingsModels.ConfidentialityUserData,
                               completion: @escaping (Result<Void, Error>) -> Void)
    func saveNewRestrictions(_ newUserRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData)
}
