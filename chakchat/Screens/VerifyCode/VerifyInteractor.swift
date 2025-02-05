//
//  VerifyInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
 
// MARK: - VerifyInteractor
final class VerifyInteractor: VerifyBusinessLogic {
    
    // MARK: - Properties
    private var presentor: VerifyPresentationLogic
    private var worker: VerifyWorkerLogic
    private var errorHandler: ErrorHandlerLogic
    var state: SignupState
    
    var onRouteToSignupScreen: ((SignupState) -> Void)?
    var onRouteToChatScreen: ((SignupState) -> Void)?
    var onRouteToSendCodeScreen: ((SignupState) -> Void)?
    
    // MARK: - Initialization
    init(presentor: VerifyPresentationLogic,
         worker: VerifyWorkerLogic,
         errorHandler: ErrorHandlerLogic,
         state: SignupState) {
        self.presentor = presentor
        self.worker = worker
        self.errorHandler = errorHandler
        self.state = state
    }
    
    // MARK: - Verification Request
    func sendVerificationRequest(_ code: String) {
        print("Send request to worker")
        
        if (state == SignupState.signin) {
            guard let key = worker.getVerifyCode(KeychainManager.keyForSaveSigninCode) else {
                print("Can't find verify key in keychain storage.")
                return
            }

            worker.sendVerificationRequest(VerifyModels.VerifySigninRequest(signinKey: key, code: code),                 SigninEndpoints.signinEndpoint.rawValue, SuccessModels.Tokens.self) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let state):
                    self.routeToChatScreen(state)
                case .failure(let error):
                    let errorId = self.errorHandler.handleError(error)
                    self.presentor.showError(errorId)
                }
            }
        } else if (state == SignupState.signupVerifyCode) {
            guard let key = worker.getVerifyCode(KeychainManager.keyForSaveSignupCode) else {
                print("Can't find verify key in keychain storage.")
                return
            }
            
            worker.sendVerificationRequest(VerifyModels.VerifySignupRequest(signupKey: key, code: code), SignupEndpoints.verifyCodeEndpoint.rawValue, SuccessModels.VerifySignupData.self) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let state):
                    self.routeToSignupScreen(state)
                case .failure(let error):
                    let errorId = self.errorHandler.handleError(error)
                    self.presentor.showError(errorId)
                }
            }
        }
        // routeToSignupScreen(SignupState.signup)
    }
    
    // MARK: - Routing
    func routeToSignupScreen(_ state: SignupState) {
        onRouteToSignupScreen?(state)
    }
    
    func routeToChatScreen(_ state: SignupState) {
        onRouteToChatScreen?(state)
    }
    
    func routeToSendCodeScreen(_ state: SignupState) {
        onRouteToSendCodeScreen?(state)
    }
    
    // MARK: - Get Phone
    func getPhone() {
        let phone = worker.getPhone()
        presentor.showPhone(phone)
    }
    
    // MARK: - Resend Code Request
    func resendCodeRequest(_ request: VerifyModels.ResendCodeRequest) {
        print("Send request to worker")
        if (state == SignupState.signin) {
            worker.resendInRequest(request) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(_):
                    self.successTransition()
                case .failure(let error):
                    let errorId = self.errorHandler.handleError(error)
                    self.presentor.showError(errorId)
                }
            }
        } else if (state == SignupState.signupVerifyCode) {
            worker.resendUpRequest(request) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(_):
                    self.successTransition()
                case .failure(let error):
                    let errorId = self.errorHandler.handleError(error)
                    self.presentor.showError(errorId)
                }
            }
        }
    }
    
    // MARK: - Routing
    func successTransition() {
        presentor.hideResendButton()
    }
}
