//
//  ProfileSettingsInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import UIKit
import OSLog

// MARK: - ProfileSettingsInteractor
final class ProfileSettingsInteractor: ProfileSettingsScreenBusinessLogic {
    
    // MARK: - Properties
    private let presenter: ProfileSettingsScreenPresentationLogic
    private let worker: ProfileSettingsScreenWorkerLogic
    private let eventPublisher: EventPublisherProtocol
    private let errorHandler: ErrorHandlerLogic
    private let logger: OSLog
    
    var onRouteToSettingsMenu: (() -> Void)?
    var onRouteToRegistration: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: ProfileSettingsScreenPresentationLogic,
         worker: ProfileSettingsScreenWorkerLogic,
         eventPublisher: EventPublisherProtocol,
         errorHandler: ErrorHandlerLogic,
         logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.eventPublisher = eventPublisher
        self.errorHandler = errorHandler
        self.logger = logger
    }
    

    // MARK: - User Data Loading
    func loadUserData() {
        os_log("Loaded user data in profile settings screen", log: logger, type: .default)
        let userData = worker.getUserData()
        showUserData(userData)
    }
    
    // MARK: - User Data Showing
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        os_log("Passed user data in settigns screen to presenter", log: logger, type: .default)
        presenter.showUserData(userData)
    }
    
    // MARK: - New data Saving
    func saveNewData(_ newUserData: ProfileSettingsModels.ChangeableProfileUserData) {
        os_log("Saved new data in profile settings screen", log: logger, type: .default)
        worker.updateUserData(newUserData) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                os_log("/me/put complete", log: logger, type: .info)
                let updateProfileDataEvent = UpdateProfileDataEvent(
                    newNickname: newUserData.nickname,
                    newUsername: newUserData.username,
                    newPhoto: newUserData.photo,
                    newBirth: newUserData.dateOfBirth
                )
                os_log("Published event in profile settings screen", log: logger, type: .default)
                eventPublisher.publish(event: updateProfileDataEvent)
            case .failure(let failure):
                os_log("/me/put failed", log: logger, type: .info)
                _ = self.errorHandler.handleError(failure)
            }
        }
        os_log("Routed to settings menu screen", log: logger, type: .default)
        onRouteToSettingsMenu?()
    }
    
    func saveImage(_ image: UIImage) -> URL? {
        os_log("Started saving image in profile setting screen", log: logger, type: .default)
        guard let data = image.jpegData(compressionQuality: 0.0) else {
            return nil
        }
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileName = "\(UUID().uuidString).png"
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            do {
                print(fileURL)
                try data.write(to: fileURL)
                worker.saveImageURL(fileURL)
                os_log("File saved", log: logger, type: .info)
                return fileURL
            } catch {
                os_log("Error during file saving", log: logger, type: .error)
                return nil
            }
        }
        return nil
    }
    
    func unpackPhotoByUrl(_ url: URL) -> UIImage? {
        print(url.path)
        if FileManager.default.fileExists(atPath: url.path) {
            if let image = UIImage(contentsOfFile: url.path) {
                return image
            }
            return nil
        }
        return nil
    }
    
    func uploadImage(_ fileURL: URL, _ fileName: String, _ mimeType: String) {
        worker.uploadImage(fileURL, fileName, mimeType) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success():
                os_log("File uploaded to server", log: logger, type: .info)
            case .failure(let failure):
                os_log("File uploding to server failed", log: logger, type: .error)
                let errorID = self.errorHandler.handleError(failure)
            }
        }
    }
    
    func signOut() {
        worker.signOut { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                os_log("Signout from account, data deleted", log: logger, type: .info)
                backToRegistration()
            case .failure(let failure):
                let errorID = self.errorHandler.handleError(failure)
            }
        }
    }
    
    // MARK: - Routing
    func backToSettingsMenu() {
        os_log("Routed to settings menu screen", log: logger, type: .default)
        onRouteToSettingsMenu?()
    }
    
    func backToRegistration() {
        os_log("Routed to registration", log: logger, type: .default)
        DispatchQueue.main.async {
            self.onRouteToRegistration?()
        }
    }
}
