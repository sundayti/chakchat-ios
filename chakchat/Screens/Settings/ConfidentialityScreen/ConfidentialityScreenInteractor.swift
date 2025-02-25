//
//  ConfidentialityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
import Combine
import OSLog

// MARK: - ConfidentialityScreenInteractor
final class ConfidentialityScreenInteractor: ConfidentialityScreenBusinessLogic {
    
    // MARK: - Properties
    private let presenter: ConfidentialityScreenPresentationLogic
    private let worker: ConfidentialityScreenWorkerLogic
    private let errorHandler: ErrorHandlerLogic
    private let eventSubscriber: EventSubscriberProtocol
    private let logger: OSLog
    
    private var cancellables = Set<AnyCancellable>()
    
    var onRouteToSettingsMenu: (() -> Void)?
    var onRouteToPhoneVisibilityScreen: (() -> Void)?
    var onRouteToBirthVisibilityScreen: (() -> Void)?
    var onRouteToOnlineVisibilityScreen: (() -> Void)?
    var onRouteToBlackListScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: ConfidentialityScreenPresentationLogic, 
         worker: ConfidentialityScreenWorkerLogic,
         errorHandler: ErrorHandlerLogic,
         eventSubscriber: EventSubscriberProtocol,
         logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.errorHandler = errorHandler
        self.eventSubscriber = eventSubscriber
        self.logger = logger
        
        subscribeToEvents()
    }
    
    // MARK: - User Data
    func loadUserData() {
        os_log("Loaded user data in confidentiality settings screen", log: logger, type: .default)
        worker.getUserData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let userRestrictions):
                self.showUserData(userRestrictions)
            case .failure(let failure):
                _ = self.errorHandler.handleError(failure)
            }
        }
    }
    
    
    // MARK: - User Data Showing
    func showUserData(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData) {
        os_log("Passed user data in confidentiality settings screen to presenter", log: logger, type: .default)
        presenter.showUserData(userRestrictions)
    }
    
    func showOnlineRestriction(_ onlineRestriction: OnlineVisibilityStatus) {
        os_log("Passed online restrictions in confidentiality settings screen to presenter", log: logger, type: .default)
        presenter.showOnlineRestriction(onlineRestriction)
    }
    
    // MARK: - New User Data Showing
    func showNewUserData(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData) {
        os_log("Passed new user data in confidentiality settings screen to presenter", log: logger, type: .default)
        presenter.showNewUserData(userRestrictions)
    }
    
    func showNewOnlineRestriction(_ onlineRestriction: OnlineVisibilityStatus) {
        os_log("passed new online restriction in confidentiality settings screen to presenter", log: logger, type: .default)
        presenter.showNewOnlineRestriction(onlineRestriction)
    }
    
    private func subscribeToEvents() {
        eventSubscriber.subscribe(UpdateRestrictionsEvent.self) { [weak self] event in
            self?.handleRestrictionsUpdate(event)
        }.store(in: &cancellables)
        eventSubscriber.subscribe(UpdateOnlineRestrictionEvent.self) { [weak self] event in
            self?.handleOnlineRestrictionUpdate(event)
        }.store(in: &cancellables)
    }

    func handleRestrictionsUpdate(_ event: UpdateRestrictionsEvent) {
        os_log("Handled restriction event in confidentiality settings screen", log: logger, type: .default)
        let newUserRestrictions = ConfidentialitySettingsModels.ConfidentialityUserData(
            phone: ConfidentialityDetails(openTo: event.newPhone.openTo, 
                                          specifiedUsers: event.newPhone.specifiedUsers),
            dateOfBirth: ConfidentialityDetails(openTo: event.newDateOfBirth.openTo,
                                                specifiedUsers: event.newDateOfBirth.specifiedUsers)
        )
        showNewUserData(newUserRestrictions)
    }
    
    func handleOnlineRestrictionUpdate(_ event: UpdateOnlineRestrictionEvent) {
        os_log("Handled online restriction event in confidentiality settings screen", log: logger, type: .default)
        let newOnlineRestriction = OnlineVisibilityStatus(status: event.newOnline)
        showNewOnlineRestriction(newOnlineRestriction)
        
    }
    // MARK: - Routing
    func routeToPhoneVisibilityScreen() {
        os_log("Routed to phone visibility screen", log: logger, type: .default)
        onRouteToPhoneVisibilityScreen?()
    }
    
    func routeToBirthVisibilityScreen() {
        os_log("Routed to birth visibility screen", log: logger, type: .default)
        onRouteToBirthVisibilityScreen?()
    }
    
    func routeToOnlineVisibilityScreen() {
        os_log("Routed to online status visibility screen", log: logger, type: .default)
        onRouteToOnlineVisibilityScreen?()
    }
    
    func routeToBlackListScreen() {
        os_log("Routed to black list screen", log: logger, type: .default)
        onRouteToBlackListScreen?()
    }
    
    func backToSettingsMenu() {
        os_log("Routed to settings menu screen", log: logger, type: .default)
        onRouteToSettingsMenu?()
    }
}
