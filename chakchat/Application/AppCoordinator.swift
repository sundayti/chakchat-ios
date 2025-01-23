//
//  AppCoordinator.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit

// MARK: - AppCoordinator
final class AppCoordinator {
    
    // MARK: - Properties
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let signupContext: SignupContext

    // MARK: - Initialization
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.signupContext = SignupContext(keychainManager: KeychainManager(), errorHandler: ErrorHandler(), userDefaultManager: UserDefaultsManager(), state: AppState._default)
    }

    func start() {
        let startVC = CreateStartScreen()
        navigationController.setViewControllers([startVC], animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    // MARK: - Start Screen Creation
    private func CreateStartScreen() -> UIViewController {
        return StartAssembly.build(with: signupContext, coordinator: self)
    }
    
    // MARK: - Registration Screen Showing
    func showRegistrationScreen() {
        let registrationVC = SendCodeAssembly.build(with: signupContext, coordinator: self)
        navigationController.pushViewController(registrationVC, animated: true)
    }

    // MARK: - Verify Screen Showing
    func showVerifyScreen() {
        let verifyVC = VerifyAssembly.build(with: signupContext, coordinator: self)
        navigationController.pushViewController(verifyVC, animated: true)
    }
    
    // MARK: - Signup Screen Showing
    func showSignupScreen() {
        let signupVC = SignupAssembly.build(with: signupContext, coordinator: self)
        navigationController.pushViewController(signupVC, animated: true)
    }
    
    // MARK: - Signup Flow Finishing
    func finishSignupFlow() {
        let chatVC = CreateChatScreen()
        navigationController.setViewControllers([chatVC], animated: true)
    }
    
    // MARK: - Popping Screen
    func popScreen() {
        navigationController.popViewController(animated: true)
    }

    // MARK: - Chat Screen Creation
    private func CreateChatScreen() -> UIViewController {
        return ChatsAssembly.build(with: signupContext, coordinator: self)
    }
    
    func showSettingsScreen() {
        let settingsVC = SettingsScreenAssembly.build()
        navigationController.pushViewController(settingsVC, animated: true)
    }
}
