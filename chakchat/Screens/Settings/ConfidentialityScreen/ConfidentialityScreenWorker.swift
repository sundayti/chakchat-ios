//
//  ConfidentialityScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
final class ConfidentialityScreenWorker: ConfidentialityScreenWorkerLogic {
    
    let userDefaultsManager: UserDefaultsManagerProtocol
    
    init(userDefaultsManager: UserDefaultsManagerProtocol) {
        self.userDefaultsManager = userDefaultsManager
    }
}
