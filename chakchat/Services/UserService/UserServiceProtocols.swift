//
//  MeServiceProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 12.02.2025.
//

import Foundation

protocol UserServiceProtocol {
    func sendGetMeRequest(completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, Error>) -> Void)
    
    func sendPutMeRequest(_ request: ProfileSettingsModels.ChangeableProfileUserData,
                       completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, Error>) -> Void)
    
    func sendGetRestrictionRequest(completion: @escaping (Result<ConfidentialitySettingsModels.ConfidentialityUserData, Error>) -> Void)
    
    func sendPutRestrictionRequest(_ request: ConfidentialitySettingsModels.ConfidentialityUserData,
                                   completion: @escaping (Result<Void, Error>) -> Void)
}

