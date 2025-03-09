//
//  GroupProfileEditModels.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation

enum GroupProfileEditModels {
    struct ProfileData {
        let chatID: UUID
        let name: String
        let description: String?
        let photoURL: URL?
    }
}
