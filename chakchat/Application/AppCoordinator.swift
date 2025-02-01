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
        self.signupContext = SignupContext(keychainManager: KeychainManager(), errorHandler: ErrorHandler(), userDefaultManager: UserDefaultsManager(), eventManager: EventManager(), state: AppState._default)
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
        return ProfileSettingsAssembly.build(with: signupContext, coordinator: self)

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
    
    // MARK: - Settings Screen Showing
    func showSettingsScreen() {
        let settingsVC = SettingsScreenAssembly.build(with: signupContext, coordinator: self)
        navigationController.pushViewController(settingsVC, animated: true)
    }
    
    // MARK: - Profile Settings Screen Showing
    func showProfileSettingsScreen() {
        let profileSettingsVC = ProfileSettingsAssembly.build(with: signupContext, coordinator: self)
        navigationController.pushViewController(profileSettingsVC, animated: true)
    }
    
    // MARK: - Confidentiality Screen Showing
    func showConfidentialityScreen() {
        let confVC = ConfidentialityScreenAssembly.build(with: signupContext, coordinator: self)
        navigationController.pushViewController(confVC, animated: true)
    }
    
    // MARK: - Phone Visibility Screen Showing
    func showPhoneVisibilityScreen() {
        let phoneVisibilityVC = PhoneVisibilityScreenAssembly.build(with: signupContext, coordinator: self)
        navigationController.pushViewController(phoneVisibilityVC, animated: true)
    }
    
    // MARK: - Birth Visibility Screen Showing
    func showBirthVisibilityScreen() {
        let birthVisibilityVC = BirthVisibilityScreenAssembly.build(with: signupContext, coordinator: self)
        navigationController.pushViewController(birthVisibilityVC, animated: true)
    }
    
    // MARK: - Online Visibility Screen Showing
    func showOnlineVisibilityScreen() {
        let onlineVisibilityVC = OnlineVisibilityScreenAssembly.build(with: signupContext, coordinator: self)
        navigationController.pushViewController(onlineVisibilityVC, animated: true)
    }
    
    // MARK: - Notofocation Screen Showing
    func showNotificationScreen() {
        let notificationVC = NotificationScreenAssembly.build(with: signupContext, coordinator: self)
        navigationController.pushViewController(notificationVC, animated: true)
    }
}
