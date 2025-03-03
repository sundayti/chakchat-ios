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

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        let keychainManager = KeychainManager()
        let identityService = IdentityService()
        let userDefaultsManager = UserDefaultsManager()
        let errorHandler = ErrorHandler(keychainManager: keychainManager, identityService: identityService)
        self.signupContext = SignupContext(keychainManager: keychainManager,
                                           errorHandler: errorHandler,
                                           userDefaultsManager: userDefaultsManager,
                                           state: SignupState._default,
                                           logger: OSLog(subsystem: "com.chakchat.mainlog", category: "MainLog"))
        let eventManager = EventManager()
        self.mainAppContext = MainAppContext(keychainManager: signupContext.keychainManager,
                                             errorHandler: signupContext.errorHandler,
                                             userDefaultsManager: signupContext.userDefaultsManager,
                                             eventManager: EventManager(),
                                             coreDataManager: CoreDataManager(),
                                             state: AppState._default,
                                             logger: signupContext.logger)
    }

    // MARK: - Start
    func start() {
        let startVC = CreateStartScreen()
        navigationController.pushViewController(startVC, animated: false)
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
        navigationController.setViewControllers([registrationVC], animated: true)
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
    
    func showUserSettingsScreen() {
        let userSettingsVC = UserProfileScreenAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(userSettingsVC, animated: true)
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
    
    // MARK: - Notification Screen Showing
    func showNotificationScreen() {
        let notificationVC = NotificationScreenAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(notificationVC, animated: true)
    }
    
    // MARK: - Language Screen Showing
    func showLanguageScreen() {
        let languageVC = LanguageAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(languageVC, animated: true)
    }
    
    // MARK: - AppTheme Screen Showing
    func showAppThemeScreen() {
        let appThemeVC = AppThemeAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(appThemeVC, animated: true)
    }
    
    // MARK: - Cache Screen Showing
    func showCacheScreen() {
        let cacheVC = CacheAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(cacheVC, animated: true)
    }
    
    // MARK: - Help Screen Showing
    func showHelpScreen() {
        let helpVC = HelpAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(helpVC, animated: true)
    }
    
    // MARK: - Black List Screen Showing
    func showBlackListScreen() {
        let blackListVC = BlackListAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(blackListVC, animated: true)
    }
    
    // MARK: - New message Screen Showing
    func showNewMessageScreen() {
        let newMessageVC = NewMessageAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(newMessageVC, animated: true)
    }
    
    func showUserProfileScreen(_ userData: ProfileSettingsModels.ProfileUserData) {
        let userProfileVC = UserProfileAssembly.build(mainAppContext, coordinator: self, userData: userData)
        navigationController.pushViewController(userProfileVC, animated: true)
    }
    
    func showChatScreen(_ userData: ProfileSettingsModels.ProfileUserData) {
        let chatVC = ChatAssembly.build(mainAppContext, coordinator: self, userData: userData)
        navigationController.pushViewController(chatVC, animated: true)
    }

    // MARK: - New group Screen Showing
    func showNewGroupScreen() {
        let newGroupVC = NewGroupAssembly.build(with: mainAppContext, coordinator: self)
        navigationController.pushViewController(newGroupVC, animated: true)
    }
}
