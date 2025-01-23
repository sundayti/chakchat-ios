//
//  RegistrationModel.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation

// MARK: - SendCodeModels
enum SendCodeModels {
    
    // MARK: - Request Models
    struct SendCodeRequest: Codable {
        let phone: String
    }
}
