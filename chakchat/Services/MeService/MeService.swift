//
//  MeService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 12.02.2025.
//

import Foundation

final class MeService: MeServiceProtocol {
    func sendGetMeRequest(completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, any Error>) -> Void) {
        completion(.success(ProfileSettingsModels.ProfileUserData(id: UUID(), nickname: "Mockname", username: "Mockusername", phone: "79776002210", dateOfBirth: "13.02.2025")))
    }
    
    func sendPutMeRequest(_ request: ProfileSettingsModels.ChangeableProfileUserData, completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, any Error>) -> Void) {
        completion(.success(ProfileSettingsModels.ProfileUserData(id: UUID(), nickname: "PutMockname", username: "PutUsername", phone: "79776002210", dateOfBirth: "11.02.2025")))
    }
    
}
// use in non-mock realization
//struct EmptyRequest: Codable {}
