//
//  RegistrationInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit
class SendCodeInteractor: SendCodeBusinessLogic {

    private var presenter: SendCodePresentationLogic
    private var worker: SendCodeWorkerLogic
    private var errorHandler: ErrorHandlerLogic
    private var state: AppState
    
    var onRouteToVerifyScreen: ((AppState) -> Void)?
    
    init(presenter: SendCodePresentationLogic, 
         worker: SendCodeWorkerLogic,
         state: AppState,
         errorHandler: ErrorHandlerLogic) {
        
        self.presenter = presenter
        self.worker = worker
        self.state = state
        self.errorHandler = errorHandler
    }
    
    func sendCodeRequest(_ request: SendCodeModels.SendCodeRequest) {
        print("Send request to worker")
        worker.sendInRequest(request) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let state):
                self.successTransition(state)
            case .failure(let error):
                let errorId = self.errorHandler.handleError(error)
                self.presenter.showError(errorId)
            }
        }
//        successTransition(AppState.signupVerifyCode)
    }
    
    func successTransition(_ state: AppState) {
        
        onRouteToVerifyScreen?(state)
    }
}
