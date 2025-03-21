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
    private let userDefautlsManager: UserDefaultsManagerProtocol
    private let identityService: IdentityServiceProtocol
    
    // MARK: - Initialization
    init(keychainManager: KeychainManagerBusinessLogic, userDefautlsManager: UserDefaultsManagerProtocol, identityService: IdentityServiceProtocol) {
        self.keychainManager = keychainManager
        self.userDefautlsManager = userDefautlsManager
        self.identityService = identityService
    }
    
    // MARK: - Public Methods
    func sendRequest(_ request: SignupModels.SignupRequest, completion: @escaping (Result<SignupState, Error>) -> Void) {
        print("Send request to service")
        identityService.sendSignupRequest(request) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {return}
                switch result {
                case .success(let successResponse):
                    self.userDefautlsManager.saveNickname(request.name)
                    self.userDefautlsManager.saveUsername(request.username)
                    self.saveToken(successResponse.data, completion: completion)
                case .failure(let apiError):
                    completion(.failure(apiError))
                }
            }
        }
    }
    
    func getSignupCode() -> UUID? {
        guard let savedSignupKey = keychainManager.getUUID(key: KeychainManager.keyForSaveSignupCode) else {
            return nil
        }
        return savedSignupKey
    }
    
    func saveToken(_ successResponse: SuccessModels.Tokens,
                   completion: @escaping (Result<SignupState, Error>) -> Void) {
        var isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveAccessToken,
                                           value: successResponse.accessToken)
        if !isSaved {
            completion(.failure(Keychain.KeychainError.saveError))
        }
        
        isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveRefreshToken,
                                            value: successResponse.refreshToken)
        
        if isSaved {
            completion(.success(SignupState.onChatsMenu))
            print("Saved tokens: \nAccess:\(successResponse.accessToken)\nRefresh:\(successResponse.refreshToken)")
        } else {
            completion(.failure(Keychain.KeychainError.saveError))
        }
    }
}
