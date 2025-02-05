//
//  AppCoordinator.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
import OSLog

// MARK: - AppCoordinator
final class AppCoordinator {
    
    // MARK: - Properties
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let signupContext: SignupContextProtocol
    private let mainAppContext: MainAppContextProtocol

    // MARK: - Initialization
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.signupContext = SignupContext(keychainManager: KeychainManager(),
                                           errorHandler: ErrorHandler(),
                                           userDefaultsManager: UserDefaultsManager(),
                                           state: SignupState._default,
                                           logger: OSLog(subsystem: "com.chakchat.mainlog", category: "MainLog"))
        
        self.mainAppContext = MainAppContext(keychainManager: signupContext.keychainManager,
                                             errorHandler: signupContext.errorHandler,
                                             userDefaultsManager: signupContext.userDefaultsManager,
                                             eventManager: EventManager(),
                                             state: AppState._default,
                                             logger: signupContext.logger)
    }

    // MARK: - Start
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
        return ChatsAssembly.build(with: mainAppContext, coordinator: self)
    }
    
    // MARK: - Settings Screen Showing
    func showSettingsScreen() {
        let settingsVC = SettingsScreenAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(settingsVC, animated: true)
    }
    
    // MARK: - Profile Settings Screen Showing
    func showProfileSettingsScreen() {
        let profileSettingsVC = ProfileSettingsAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(profileSettingsVC, animated: true)
    }
    
    // MARK: - Confidentiality Screen Showing
    func showConfidentialityScreen() {
        let confVC = ConfidentialityScreenAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(confVC, animated: true)
    }
    
    // MARK: - Phone Visibility Screen Showing
    func showPhoneVisibilityScreen() {
        let phoneVisibilityVC = PhoneVisibilityScreenAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(phoneVisibilityVC, animated: true)
    }
    
    // MARK: - Birth Visibility Screen Showing
    func showBirthVisibilityScreen() {
        let birthVisibilityVC = BirthVisibilityScreenAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(birthVisibilityVC, animated: true)
    }
    
    // MARK: - Online Visibility Screen Showing
    func showOnlineVisibilityScreen() {
        let onlineVisibilityVC = OnlineVisibilityScreenAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(onlineVisibilityVC, animated: true)
    }
    
    // MARK: - Notofocation Screen Showing
    func showNotificationScreen() {
        let notificationVC = NotificationScreenAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(notificationVC, animated: true)
    }
}
