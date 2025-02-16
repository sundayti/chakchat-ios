//
//  NotificationScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation
import OSLog

// MARK: - NotificationScreenInteractor
final class NotificationScreenInteractor: NotificationScreenBusinessLogic {
    
    // MARK: - Properties
    private let presenter: NotificationScreenPresentationLogic
    private let worker: NotificationScreenWorkerLogic
    private let eventManager: EventPublisherProtocol
    private var userData: NotificationScreenModels.NotificationStatus
    private let snap: NotificationScreenModels.NotificationStatus
    private let logger: OSLog
    
    var onRouteToSettingsMenu: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: NotificationScreenPresentationLogic,
         worker: NotificationScreenWorkerLogic,
         eventManager: EventPublisherProtocol,
         userData: NotificationScreenModels.NotificationStatus,
         logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.eventManager = eventManager
        self.userData = userData
        self.logger = logger
        snap = userData
    }
    
    // MARK: - Public methods
    func loadUserData() {
        os_log("Loaded user data in notiffication settings screen", log: logger, type: .default)
        showUserData(userData)
    }
    
    func showUserData(_ userData: NotificationScreenModels.NotificationStatus) {
        os_log("Passed user data in notification settings screen to presenter", log: logger, type: .default)
        presenter.showUserData(userData)
    }
    
    func updateNotififcationSettings(at indexPath: IndexPath, isOn: Bool) {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            os_log("General notification status changed", log: logger, type: .debug)
            userData.generalNotification = isOn
        case (1,0):
            os_log("Audio notification status changed", log: logger, type: .debug)
            userData.audioNotification = isOn
        case (1,1):
            os_log("Vibration notification status changed", log: logger, type: .debug)
            userData.vibrationNotification = isOn
        default:
            break
        }
    }
    
    func saveNewData(_ userData: NotificationScreenModels.NotificationStatus) {
        os_log("Saved new data in notification settings screen", log: logger, type: .default)
        worker.saveNewData(userData)
    }
    
    func backToSettingsMenu() {
        saveNewData(userData)
        checkUpdates()
        os_log("Routed to settings menu screen", log: logger, type: .default)
        onRouteToSettingsMenu?()
    }
    
    private func checkUpdates() {
        let concurrentQueue = DispatchQueue.global(qos: .userInitiated)
        
        if snap.generalNotification != userData.generalNotification {
            concurrentQueue.async {
                let updateGeneralNotificationEvent = UpdateGeneralNotififcationEvent(
                    newGeneralNotififcationStatus: self.userData.generalNotification
                )
                os_log("Event published in notification screen(general status changed)", log: self.logger, type: .default)
                self.eventManager.publish(event: updateGeneralNotificationEvent)
            }
        }
        if snap.audioNotification != userData.audioNotification {
            concurrentQueue.async {
                let updateAudioNotificationEvent = UpdateAudioNotificationEvent(
                    newAudioNotificationStatus: self.userData.audioNotification
                )
                os_log("Event published in notification screen(audio status changed)", log: self.logger, type: .default)
                self.eventManager.publish(event: updateAudioNotificationEvent)
            }
        }
        if snap.vibrationNotification != userData.vibrationNotification {
            concurrentQueue.async {
                let updateVibrationNotificationEvent = UpdateVibrationNotificationEvent(
                    newVibrationNotificationStatus: self.userData.vibrationNotification
                )
                os_log("Event published in notification screen(vibration status changed)", log: self.logger, type: .default)
                self.eventManager.publish(event: updateVibrationNotificationEvent)
            }
        }
    }
}
