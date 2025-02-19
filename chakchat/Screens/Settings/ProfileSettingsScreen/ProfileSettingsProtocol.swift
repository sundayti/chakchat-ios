//
//  ProfileSettingsProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import UIKit

// MARK: - ProfileSettingsBusinessLogic
protocol ProfileSettingsScreenBusinessLogic {
    func backToSettingsMenu()
    func backToRegistration()
    func saveNewData(_ newUserData: ProfileSettingsModels.ChangeableProfileUserData)
    func loadUserData()
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData)
    
    func signOut()
    
    func unpackPhotoByUrl(_ url: URL) -> UIImage?
    
    func saveImage(_ image: UIImage) -> URL?
    func uploadImage(_ fileURL: URL, _ fileName: String, _ mimeType: String)
}

// MARK: - ProfileSettingsPresentationLogic
protocol ProfileSettingsScreenPresentationLogic {
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData)
}

protocol ProfileSettingsScreenWorkerLogic {
    func updateUserData(_ request: ProfileSettingsModels.ChangeableProfileUserData, completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, Error>) -> Void)
    func getUserData() -> ProfileSettingsModels.ProfileUserData
    func saveImagePath(_ path: String)
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void)
    
    func uploadImage(_ fileURL: URL,
                     _ fileName: String,
                     _ mimeType: String,
                     completion: @escaping (Result<Void, Error>) -> Void)
}
