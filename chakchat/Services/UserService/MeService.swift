//
//  MeService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 12.02.2025.
//

import Foundation
//TODO: - when Anya created user service, you have to delete mock and implement logic!
final class MeService: MeServiceProtocol, MeServiceRestrictionProtocol {
    
    let u = UserDefaultsManager()
    
    func sendGetMeRequest(completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, any Error>) -> Void) {
        completion(.success(ProfileSettingsModels.ProfileUserData(id: UUID(), nickname: "Mockname", username: "Mockusername", phone: "79776002210",photo: u.loadPhotoURL(), dateOfBirth: "13.02.2025")))
    }
    
    func sendPutMeRequest(_ request: ProfileSettingsModels.ChangeableProfileUserData, completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, any Error>) -> Void) {
        completion(.success(ProfileSettingsModels.ProfileUserData(id: UUID(), nickname: "PutMockname", username: "PutUsername", phone: "79776002210", dateOfBirth: "11.02.2025")))
    }
    
    func sendGetRestrictionRequest(completion: @escaping (Result<ConfidentialitySettingsModels.ConfidentialityUserData, any Error>) -> Void) {
//        Sender.Get(requestBody: nil as EmptyRequest?, responseType: ConfidentialitySettingsModels.ConfidentialityUserData.self, endpoint: UserServiceEndpoints.meRestrictions.rawValue, completion: completion)
        completion(.success(ConfidentialitySettingsModels.ConfidentialityUserData(
            phone: ConfidentialityDetails(openTo: "everyone", specifiedUsers: nil),
            dateOfBirth: ConfidentialityDetails(openTo: "only_me", specifiedUsers: nil))
        ))
    }
    
    func sendPutRestrictionRequest(_ request: ConfidentialitySettingsModels.ConfidentialityUserData, completion: @escaping (Result<Void, any Error>) -> Void) {
        completion(.success(()))
    }
    
}
struct EmptyRequest: Codable {}
