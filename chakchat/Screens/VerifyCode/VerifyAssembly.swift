//
//  VerifyAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit

// MARK: - VerifyAssembly
enum VerifyAssembly {
    
    // MARK: - Assembly Method
    static func build(with context: SignupContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        
        let presenter = VerifyPresenter()
        let verificationService = VerificationService()
        let sendCodeService = SendCodeService()
        
        let worker = VerifyWorker(verificationService: verificationService, keychainManager: context.keychainManager, userDefaultsManager: context.userDefaultsManager, sendCodeService: sendCodeService)
        
        let interactor = VerifyInteractor(presentor: presenter,
                                          worker: worker,
                                          errorHandler: context.errorHandler, 
                                          state: context.state,
                                          logger: context.logger
        )
        let view = VerifyViewController(interactor: interactor)
        presenter.view = view
        
        interactor.onRouteToSignupScreen = { [weak context, weak coordinator] state in
            context?.state = state
            print(state)
            coordinator?.showSignupScreen()
        }
        
        interactor.onRouteToChatScreen = { [weak context, weak coordinator] state in
            context?.state = state
            print(state)
            coordinator?.finishSignupFlow()
        }
        
        interactor.onRouteToSendCodeScreen = { [weak context, weak coordinator] state in
            context?.state = state
            print(state)
            coordinator?.popScreen()
        }
        
        return view
    }
}
