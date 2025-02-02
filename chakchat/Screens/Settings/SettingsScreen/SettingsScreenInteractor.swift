//
//  SettingsScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
import Combine

// MARK: - SettingsScreenInteractor
final class SettingsScreenInteractor: SettingsScreenBusinessLogic {
    
    // MARK: - Properties
    var presenter: SettingsScreenPresentationLogic
    var worker: SettingsScreenWorkerLogic
    var userData: SettingsScreenModels.UserData
    var eventSubscriber: EventSubscriberProtocol
    
    var onRouteToProfileSettings: (() -> Void)?
    var onRouteToConfidentialitySettings: (() -> Void)?
    var onRouteToNotificationsSettings: (() -> Void)?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(presenter: SettingsScreenPresentationLogic, worker: SettingsScreenWorkerLogic, userData: SettingsScreenModels.UserData, eventSubscriber: EventSubscriberProtocol) {
        self.presenter = presenter
        self.worker = worker
        self.userData = userData
        self.eventSubscriber = eventSubscriber
        
        subscribeToEvents()
    }
    
    // MARK: - User Data Loading
    func loadUserData() {
        showUserData(userData)
    }
    
    // MARK: - User Data Updating
    func updateUserData() {
        showNewUserData(userData)
    }
    
    // MARK: - User Data Showing
    func showUserData(_ data: SettingsScreenModels.UserData) {
        presenter.showUserData(data)
    }
    
    // MARK: - New User Data Showing
    func showNewUserData(_ data: SettingsScreenModels.UserData) {
        presenter.showNewUserData(data)
    }
    
    // MARK: - Routing
    func profileSettingsRoute() {
        onRouteToProfileSettings?()
    }
    
    func confidentialitySettingsRoute() {
        onRouteToConfidentialitySettings?()
    }
    
    func notificationSettingsRoute() {
        onRouteToNotificationsSettings?()
    } 
    
    func subscribeToEvents() {
        eventSubscriber.subscribe(UpdateProfileDataEvent.self) { [weak self] event in
            self?.handleUserDataChangedEvent(event)
        }.store(in: &cancellables)
    }
    
    func handleUserDataChangedEvent(_ event: UpdateProfileDataEvent) {
        userData.nickname = event.newNickname
        userData.username = event.newUsername
        DispatchQueue.main.async {
            self.updateUserData()
        }
    }
}
