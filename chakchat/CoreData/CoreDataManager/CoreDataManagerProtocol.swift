//
//  CoreDataManagerProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.02.2025.
//

import Foundation

protocol CoreDataManagerProtocol {
    func fetchChats() -> [Chat]?
    func createChat(_ chatData: ChatsModels.GeneralChatModel.ChatData)
    func fetchChatByMembers(_ myID: UUID, _ memberID: UUID, _ type: ChatType) -> Chat?
    func updateChat(_ chatData: ChatsModels.GeneralChatModel.ChatData)
    func deleteChat(_ chatID: UUID)
    
    func createUser(_ userData: ProfileSettingsModels.ProfileUserData)
    func createUsers(_ usersData: ProfileSettingsModels.Users)
    func fetchUsers() -> [User]
    func deleteUser(_ user: User)
    func deleteAllUsers()
}
