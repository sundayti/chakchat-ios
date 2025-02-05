//
//  NotificationScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation

// MARK: - NotificationScreenInteractor
final class NotificationScreenInteractor: NotificationScreenBusinessLogic {
    
    // MARK: - Properties
    let presenter: NotificationScreenPresentationLogic
    let worker: NotificationScreenWorkerLogic
    let eventManager: EventPublisherProtocol
    var userData: NotificationScreenModels.NotificationStatus
    let snap: NotificationScreenModels.NotificationStatus
    var onRouteToSettingsMenu: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: NotificationScreenPresentationLogic, worker: NotificationScreenWorkerLogic, eventManager: EventPublisherProtocol, userData: NotificationScreenModels.NotificationStatus) {
        self.presenter = presenter
        self.worker = worker
        self.eventManager = eventManager
        self.userData = userData
        snap = userData
    }
    
    // MARK: - User Data Loading
    func loadUserData() {
        showUserData(userData)
    }
    
    // MARK: - User Data Showing
    func showUserData(_ userData: NotificationScreenModels.NotificationStatus) {
        presenter.showUserData(userData)
    }
    
    // MARK: - New Data Saving
    func updateNotififcationSettings(at indexPath: IndexPath, isOn: Bool) {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            print("General notification status was \(userData.generalNotification), now \(isOn)")
            userData.generalNotification = isOn
        case (1,0):
            print("Audio notification status was \(userData.audioNotification), now \(isOn)")
            userData.audioNotification = isOn
        case (1,1):
            print("Vibration notification status was \(userData.vibrationNotification), now \(isOn)")
            userData.vibrationNotification = isOn
        default:
            break
        }
    }
    
    func saveNewData(_ userData: NotificationScreenModels.NotificationStatus) {
        print("Saving new data")
        worker.saveNewData(userData)
    }
    
    // MARK: - Routing
    func backToSettingsMenu() {
        saveNewData(userData)
        checkUpdates()
        onRouteToSettingsMenu?()
    }
    
    private func checkUpdates() {
        let concurrentQueue = DispatchQueue.global(qos: .userInitiated)
        
        if snap.generalNotification != userData.generalNotification {
            concurrentQueue.async {
                let updateGeneralNotificationEvent = UpdateGeneralNotififcationEvent(
                    newGeneralNotififcationStatus: self.userData.generalNotification
                )
                self.eventManager.publish(event: updateGeneralNotificationEvent)
            }
        }
        if snap.audioNotification != userData.audioNotification {
            concurrentQueue.async {
                let updateAudioNotificationEvent = UpdateAudioNotificationEvent(
                    newAudioNotificationStatus: self.userData.audioNotification
                )
                self.eventManager.publish(event: updateAudioNotificationEvent)
            }
        }
        if snap.vibrationNotification != userData.vibrationNotification {
            concurrentQueue.async {
                let updateVibrationNotificationEvent = UpdateVibrationNotificationEvent(
                    newVibrationNotificationStatus: self.userData.vibrationNotification
                )
                self.eventManager.publish(event: updateVibrationNotificationEvent)
            }
        }
    }
}
