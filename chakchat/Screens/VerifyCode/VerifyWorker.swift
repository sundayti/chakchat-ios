//
//  VerifyWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation

// MARK: - VerifyWorker
final class VerifyWorker: VerifyWorkerLogic {
    
    // MARK: - Properties
    private let verificationService: VerificationServiceLogic
    private let keychainManager: KeychainManagerBusinessLogic
    private let userDefaultsManager: UserDefaultsManagerProtocol
    private let sendCodeService: SendCodeServiceLogic

    // MARK: - Initialization
    init(verificationService: VerificationServiceLogic, keychainManager: KeychainManagerBusinessLogic, userDefaultsManager: UserDefaultsManagerProtocol, sendCodeService: SendCodeServiceLogic) {
        self.verificationService = verificationService
        self.keychainManager = keychainManager
        self.userDefaultsManager = userDefaultsManager
        self.sendCodeService = sendCodeService
    }
    
    // MARK: - Verification Request
    func sendVerificationRequest<Request, Response>(_ request: Request, _ endpoint: String, _ responseType: Response.Type, completion: @escaping (Result<AppState, any Error>) -> Void) where Request : Decodable, Request : Encodable, Response : Decodable, Response : Encodable {
        print("Send request to service")
        verificationService.sendVerificationRequest(request,
                                                    endpoint,
                                                    responseType) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {return}
                switch result {
                case .success(let successResponse):
                    guard let successResponse = successResponse as? SuccessModels.Tokens else {
                        completion(.success(AppState.signup))
                        return
                    }
                    self.saveToken(successResponse, completion: completion)
                    completion(.success(AppState.onChats))
                case .failure(let apiError):
                    completion(.failure(apiError))
                }
            }
        }
    }
    
    // MARK: - Verify Code Getting
    func getVerifyCode(_ key: String) -> UUID? {
        guard let savedKey = keychainManager.getUUID(key: key) else {
            return nil
        }
        return savedKey
    }
    
    // MARK: - Token Saving
    func saveToken(_ response: SuccessModels.Tokens,
                   completion: @escaping (Result<AppState, Error>) -> Void) {
        var isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveAccessToken,
                                           value: response.accessToken)
        if !isSaved {
            completion(.failure(Keychain.KeychainError.saveError))
        }
        
        isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveRefreshToken,
                                            value: response.refreshToken)
        if isSaved {
            print("Saved tokens: \nAccess:\(response.accessToken)\nRefresh:\(response.refreshToken)")
            completion(.success(AppState._default))
        } else {
            completion(.failure(Keychain.KeychainError.saveError))
        }
    }
    
    // MARK: - Get Phone
    func getPhone() -> String {
        let phone = userDefaultsManager.loadPhone()
        return phone
    }
    
    // MARK: - SendIn Requests
    func resendInRequest(_ request: Verify.ResendCodeRequest,
                     completion: @escaping (Result<AppState, Error>) -> Void) {
        print("Send request to service")
        sendCodeService.sendCodeRequest(request,
                                        SigninEndpoints.sendPhoneCodeEndpoint.rawValue,
                                        SuccessModels.SendCodeSigninData.self) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {return}
                switch result {
                case .success(let successResponse):
                    let isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveSigninCode,
                                                       value: successResponse.signinKey)
                    if isSaved {
                        completion(.success(AppState.signin))
                    } else {
                        completion(.failure(Keychain.KeychainError.saveError))
                    }
                case .failure(let apiError):
                    completion(.failure(apiError))
                }
            }
        }
    }
    
    // MARK: - Registration Requests
    func resendUpRequest(_ request: Verify.ResendCodeRequest,
                       completion: @escaping (Result<AppState, Error>) -> Void) {
        print("Send request to service")
        sendCodeService.sendCodeRequest(request,
                                        SignupEndpoints.sendPhoneCodeEndpoint.rawValue,
                                        SuccessModels.SendCodeSignupData.self) { [weak self]result in
            DispatchQueue.main.async {
                guard let self = self else {return}
                switch result {
                case .success(let successResponse):
                    let isSaved = self.keychainManager.save(key: KeychainManager.keyForSaveSignupCode,
                                                       value: successResponse.signupKey)
                    if isSaved {
                        completion(.success(AppState.signupVerifyCode))
                    } else {
                        completion(.failure(Keychain.KeychainError.saveError))
                    }
                case .failure(let apiError):
                    completion(.failure(apiError))
                }
            }
        }
    }
}
