//
//  SignupWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation

// MARK: - SignupWorker
final class SignupWorker: SignupWorkerLogic {

    // MARK: - Properties
    private let keychainManager: KeychainManagerBusinessLogic
    private let userDefautlsManager: UserDefaultsManager
    private let signupService: SignupServiceLogic
    
    init(keychainManager: KeychainManagerBusinessLogic, userDefautlsManager: UserDefaultsManager, signupService: SignupServiceLogic) {
        self.keychainManager = keychainManager
        self.userDefautlsManager = userDefautlsManager
        self.signupService = signupService
    }
    
    // MARK: - Request Sending
    func sendRequest(_ request: Signup.SignupRequest, completion: @escaping (Result<AppState, Error>) -> Void) {
        print("Send request to service")
        
        signupService.sendSignupRequest(request) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {return}
                switch result {
                case .success(let successResponse):
                    self.saveToken(successResponse, completion: completion)
                    self.userDefautlsManager.saveInitials(nickname: request.name, username: request.username)
                    completion(.success(AppState.onChats))
                case .failure(let apiError):
                    completion(.failure(apiError))
                }
            }
        }
    }
    
    // MARK: - Signup Code Getting
    func getSignupCode() -> UUID? {
        guard let savedSignupKey = keychainManager.getUUID(key: KeychainManager.keyForSaveSignupCode) else {
            return nil
        }
        return savedSignupKey
    }
    
    // MARK: - Token Saving
    func saveToken(_ successResponse: SuccessModels.Tokens,
                   completion: @escaping (Result<AppState, Error>) -> Void) {
        var isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveAccessToken,
                                           value: successResponse.accessToken)
        if !isSaved {
            completion(.failure(Keychain.KeychainError.saveError))
        }
        
        isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveRefreshToken,
                                            value: successResponse.refreshToken)
        
        if isSaved {
            completion(.success(AppState._default))
            print("Saved tokens: \nAccess:\(successResponse.accessToken)\nRefresh:\(successResponse.refreshToken)")
        } else {
            completion(.failure(Keychain.KeychainError.saveError))
        }
    }
}
