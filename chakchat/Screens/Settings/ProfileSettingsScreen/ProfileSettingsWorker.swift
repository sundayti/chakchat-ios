//
//  ProfileSettingsWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 13.02.2025.
//

import Foundation

final class ProfileSettingsWorker: ProfileSettingsScreenWorkerLogic {

    private let userDefaultsManager: UserDefaultsManagerProtocol
    private let meService: MeServiceProtocol
    private let fileStorageService: FileStorageServiceProtocol
    private let keychainManager: KeychainManagerBusinessLogic
    
    init(userDefaultsManager: UserDefaultsManagerProtocol,
         meService: MeServiceProtocol,
         fileStorageService: FileStorageServiceProtocol,
         keychainManager: KeychainManagerBusinessLogic
    ) {
        self.userDefaultsManager = userDefaultsManager
        self.meService = meService
        self.fileStorageService = fileStorageService
        self.keychainManager = keychainManager
    }
    
    func updateUserData(_ request: ProfileSettingsModels.ChangeableProfileUserData, completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, any Error>) -> Void) {
        meService.sendPutMeRequest(request) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let newUserData):
                self.userDefaultsManager.saveUserData(newUserData)
                completion(.success(newUserData))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func saveImagePath(_ path: String) {
        userDefaultsManager.savePhotoPath(path)
    }
    
    func uploadImage(_ fileURL: URL, _ fileName: String, _ mimeType: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        if let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) {
            fileStorageService.sendFileUploadRequest(fileURL, fileName, mimeType, accessToken) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.userDefaultsManager.savePhotoMetadata(data)
                    completion(.success(()))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        }
    }
    
    func getUserData() -> ProfileSettingsModels.ProfileUserData {
        return userDefaultsManager.loadUserData()
    }
    
}
