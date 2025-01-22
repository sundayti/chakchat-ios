//
//  KeychainManagerProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation

// MARK: - KeychainManagerBusinessLogic
protocol KeychainManagerBusinessLogic {
    func save(key: String, value: UUID) -> Bool
    func save(key: String, value: String) -> Bool
    func getUUID(key: String) -> UUID?
    func delete(key: String) -> Bool
}
