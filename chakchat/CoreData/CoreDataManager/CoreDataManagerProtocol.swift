//
//  CoreDataManagerProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.02.2025.
//

import Foundation

protocol CoreDataManagerProtocol {
    func createPersonalChat(_ chatData: ChatsModels.PersonalChat.Response)
    func fetchChatByMembers(_ myID: UUID, _ memberID: UUID) -> PersonalChat? 
    func createUser(_ userData: ProfileSettingsModels.ProfileUserData)
    func createUsers(_ usersData: ProfileSettingsModels.Users)
    func fetchUsers() -> [User]
    func deleteUser(_ user: User)
    func deleteAllUsers()
}
