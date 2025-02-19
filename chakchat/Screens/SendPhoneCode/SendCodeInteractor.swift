//
//  RegistrationInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import OSLog

// MARK: - SendCodeInteractor
class SendCodeInteractor: SendCodeBusinessLogic {

    // MARK: - Properties
    private let presenter: SendCodePresentationLogic
    private let worker: SendCodeWorkerLogic
    private let errorHandler: ErrorHandlerLogic
    private let state: SignupState
    private let logger: OSLog

    var onRouteToVerifyScreen: ((SignupState) -> Void)?
    
    // MARK: - Initialization
    init(presenter: SendCodePresentationLogic,
         worker: SendCodeWorkerLogic,
         state: SignupState,
         errorHandler: ErrorHandlerLogic,
         logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.state = state
        self.errorHandler = errorHandler
        self.logger = logger
    }
    
    // MARK: - Code Request Handling
    func sendCodeRequest(_ request: SendCodeModels.SendCodeRequest) {
        os_log("Sended get code request", log: logger, type: .info)
        worker.sendInRequest(request) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let state):
                os_log("Code received, saved", log: logger, type: .info)
                self.successTransition(state)
            case .failure(let error):
                let errorId = self.errorHandler.handleError(error)
                self.presenter.showError(errorId)
            }
        }
    }
    
    // MARK: - Routing
    func successTransition(_ state: SignupState) {
        os_log("Routed to verify screen", log: logger, type: .default)
        onRouteToVerifyScreen?(state)
    }
}
