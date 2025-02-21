//
//  MeService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 12.02.2025.
//

import Foundation
//TODO: - when Anya created user service, you have to delete mock and implement logic!
final class MeService: UserServiceProtocol {
    
    func sendGetMeRequest(completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, any Error>) -> Void) {
        completion(.success(ProfileSettingsModels.ProfileUserData(id: UUID(), name: "Mockname", username: "Mockusername", phone: "79776002210", dateOfBirth: "13.02.2025")))
    }
    
    func sendPutMeRequest(_ request: ProfileSettingsModels.ChangeableProfileUserData, completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, any Error>) -> Void) {
        completion(.success(ProfileSettingsModels.ProfileUserData(id: UUID(), name: "PutMockname", username: "PutUsername", phone: "79776002210", dateOfBirth: "11.02.2025")))
    }
    
    func sendGetRestrictionRequest(completion: @escaping (Result<ConfidentialitySettingsModels.ConfidentialityUserData, any Error>) -> Void) {
//        Sender.Get(requestBody: nil as EmptyRequest?, responseType: ConfidentialitySettingsModels.ConfidentialityUserData.self, endpoint: UserServiceEndpoints.meRestrictions.rawValue, completion: completion)
        completion(.success(ConfidentialitySettingsModels.ConfidentialityUserData(
            phone: ConfidentialityDetails(openTo: LocalizationManager.shared.localizedString(for: "all"), specifiedUsers: nil),
            dateOfBirth: ConfidentialityDetails(openTo: LocalizationManager.shared.localizedString(for: "nobody"), specifiedUsers: nil))
        ))
    }
    
    func sendPutRestrictionRequest(_ request: ConfidentialitySettingsModels.ConfidentialityUserData, completion: @escaping (Result<Void, any Error>) -> Void) {
        completion(.success(()))
    }
    
}
struct EmptyRequest: Codable {}
