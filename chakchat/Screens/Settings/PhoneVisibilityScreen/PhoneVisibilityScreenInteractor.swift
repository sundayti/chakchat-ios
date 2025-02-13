//
//  PhoneVisibilityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import OSLog

// MARK: - PhoneVisibilityScreenInteractor
final class PhoneVisibilityScreenInteractor: PhoneVisibilityScreenBusinessLogic {
    
    // MARK: - Properties
    private let presenter: PhoneVisibilityScreenPresenter
    private let worker: PhoneVisibilityScreenWorker
    private let eventManager: EventPublisherProtocol
    private let errorHandler: ErrorHandlerLogic
    private let logger: OSLog
    private let userRestrictionsSnap: ConfidentialitySettingsModels.ConfidentialityUserData
    
    var onRouteToConfidentialityScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: PhoneVisibilityScreenPresenter, 
         worker: PhoneVisibilityScreenWorker,
         eventManager: EventPublisherProtocol,
         errorHandler: ErrorHandlerLogic,
         logger: OSLog,
         userRestrictionsSnap: ConfidentialitySettingsModels.ConfidentialityUserData
    ) {
        self.presenter = presenter
        self.worker = worker
        self.eventManager = eventManager
        self.errorHandler = errorHandler
        self.logger = logger
        self.userRestrictionsSnap = userRestrictionsSnap
    }
    
    // MARK: - User Data Loading
    func loadUserRestrictions() {
        os_log("Loaded user data in phone visibility screen", log: logger, type: .default)
        showUserRestrictions(userRestrictionsSnap)
    }
    
    // MARK: - User Data Showing
    func showUserRestrictions(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData) {
        os_log("Passed user data in phone visibility screen to presenter", log: logger, type: .default)
        presenter.showUserRestrictions(userRestrictions)
    }
    
    // MARK: - New Data Saving
    func saveNewRestrictions(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData) {
        os_log("Saved new data in phone visibility screen", log: logger, type: .default)
        worker.saveNewRestrictions(userRestrictions)
    }
    
    // MARK: - Routing
    /// в будущем нужно будет не стринг передавать а целиком ConfidentialityDetails
    /// пока что стринг, потому что я сохраняю только статус кому открыта видимость номера телефона
    /// а UUID выбранных пользователей нет, потому что тот сервис я еще не трогал
    /// в dateOfBirth кладу значение из моего снапа, потому что оно не поменялось
    func backToConfidentialityScreen(_ userRestriction: String) {
        let newUserRestrictions = ConfidentialitySettingsModels.ConfidentialityUserData(
            phone: ConfidentialityDetails(openTo: userRestriction, specifiedUsers: nil),
            dateOfBirth: userRestrictionsSnap.dateOfBirth)
        saveNewRestrictions(newUserRestrictions)
        let updateRestrictionsEvent = UpdateRestrictionsEvent(newPhone: newUserRestrictions.phone,
                                                              newDateOfBirth: newUserRestrictions.dateOfBirth)
        os_log("Event published in phone visibility screen", log: logger, type: .default)
        eventManager.publish(event: updateRestrictionsEvent)
        os_log("Routed to confidentiality settings screen", log: logger, type: .default)
        onRouteToConfidentialityScreen?()
    }
}
