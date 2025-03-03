//
//  UserProfileInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import UIKit
import OSLog

final class UserProfileInteractor: UserProfileBusinessLogic {
    
    private let presenter: UserProfilePresentationLogic
    private let worker: UserProfileWorkerLogic
    private let errorHandler: ErrorHandlerLogic
    private let userData: ProfileSettingsModels.ProfileUserData
    private let logger: OSLog
    
    var onRouteToChat: ((ProfileSettingsModels.ProfileUserData) -> Void)?
    var onRouteBack: (() -> Void)?
    
    init(
        presenter: UserProfilePresentationLogic,
        worker: UserProfileWorkerLogic,
        errorHandler: ErrorHandlerLogic,
        userData: ProfileSettingsModels.ProfileUserData,
        logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.errorHandler = errorHandler
        self.userData = userData
        self.logger = logger
    }
    
    func passUserData() {
        presenter.passUserData(userData)
    }
    
    func routeToChat() {
        onRouteToChat?(userData)
    }
    
    func switchNotification() {
        /// сделать сохранение текущего состояния через userDefaultsManager, а может быть нужно как-то иначе сделать
        /// пока что реализация под вопросом
    }
    
    func searchMessages() {
        /// сделать через /{chatId}/update/message/search позже
    }
    
    func routeBack() {
        onRouteBack?()
    }
}
