//
//  SettingsScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import UIKit

// MARK: - SettingsScreenWorker
final class SettingsScreenWorker: SettingsScreenWorkerLogic {
    
    // MARK: - Properties
    private let userDefaultsManager: UserDefaultsManagerProtocol
    private let userService: UserServiceProtocol
    private let keychainManager: KeychainManagerBusinessLogic
    
    // MARK: - Initialization
    init(userDefaultsManager: UserDefaultsManagerProtocol, 
         userService: UserServiceProtocol,
         keychainManager: KeychainManagerBusinessLogic
    ) {
        self.userDefaultsManager = userDefaultsManager
        self.userService = userService
        self.keychainManager = keychainManager
    }
    
    // MARK: - Public Methods
    func getUserData() -> ProfileSettingsModels.ProfileUserData {
        let userData = userDefaultsManager.loadUserData()
        return userData
    }
    
    func loadPhoto(_ url: URL, completion: @escaping (Result<UIImage, any Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            ImageCacheManager.shared.saveImage(image, for: url as NSURL)
            completion(.success(image))
        }
        task.resume()
    }
}
