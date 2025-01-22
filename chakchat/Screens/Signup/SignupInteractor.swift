//
//  SignupInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation

class SignupInteractor: SignupBusinessLogic {

    private let presenter: SignupPresentationLogic
    private let worker: SignupWorkerLogic
    private let errorHandler: ErrorHandlerLogic
    private let state: AppState
    
    var onRouteToChatScreen: ((AppState) -> Void)?
    
    init(presenter: SignupPresentationLogic,
         worker: SignupWorkerLogic,
         state: AppState,
         errorHandler: ErrorHandlerLogic) {
        
        self.presenter = presenter
        self.worker = worker
        self.state = state
        self.errorHandler = errorHandler
    }
    
    func sendSignupRequest(_ name: String, _ username: String) {
        print("Send request to worker")
        
        guard let signupKey = worker.getSignupCode() else {
            print("Can't find signup key in keychain storage!")
            return
        }
        
        worker.sendRequest(Signup.SignupRequest(signupKey: signupKey, name: name, username: username)) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let state):
                self.successTransition(state)
            case .failure(let error):
                let errorId = self.errorHandler.handleError(error)
                self.presenter.showError(errorId)
            }
        }
       //successTransition(AppState.onChats)
    }
    
    
    func successTransition(_ state: AppState) {
        onRouteToChatScreen?(state)
    }
}
