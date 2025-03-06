//
//  CoreDataManager.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.02.2025.
//

import Foundation
import CoreData

final class CoreDataManager: CoreDataManagerProtocol {
    
    func createPersonalChat(_ chatData: ChatsModels.PersonalChat.Response) {
        let context = CoreDataStack.shared.viewContext(for: "PersonalChatModel")
        let chat = PersonalChat(context: context)
        chat.chatID = chatData.chatID
        chat.members = try? JSONEncoder().encode(chatData.members)
        chat.blocked = chatData.blocked
        chat.blockedBy = try? JSONEncoder().encode(chatData.blockedBy)
        CoreDataStack.shared.saveContext(for: "PersonalChatModel")
    }
    
    func fetchChatByMembers(_ myID: UUID, _ memberID: UUID) -> PersonalChat? {
        let context = CoreDataStack.shared.viewContext(for: "PersonalChatModel")
        let fetchRequest: NSFetchRequest<PersonalChat> = PersonalChat.fetchRequest()
        do {
            let chats = try context.fetch(fetchRequest)
            for chat in chats {
                let members = chat.getMembers()
                if members.contains(myID) && members.contains(memberID) {
                    return chat
                }
            }
        } catch {
            print("Failed to fetch chat: \(error)")
        }
        return nil
    }
    
    func createUser(_ userData: ProfileSettingsModels.ProfileUserData) {
        let context = CoreDataStack.shared.viewContext(for: "UserModel")
        let user = User(context: context)
        user.id = userData.id
        user.name = userData.name
        user.username = userData.username
        user.phone = userData.phone
        user.photo = userData.photo
        user.dateOfBirth = userData.dateOfBirth
        user.createdAt = userData.createdAt
        CoreDataStack.shared.saveContext(for: "UserModel")
    }
    
    func createUsers(_ usersData: ProfileSettingsModels.Users) {
        for userData in usersData.users {
            createUser(userData)
        }
        CoreDataStack.shared.saveContext(for: "UserModel")
    }
    
    func fetchUsers() -> [User] {
        let context = CoreDataStack.shared.viewContext(for: "UserModel")
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }
    
    func deleteUser(_ user: User) {
        let context = CoreDataStack.shared.viewContext(for: "UserModel")
        context.delete(user)
        CoreDataStack.shared.saveContext(for: "UserModel")
    }
    
    func deleteAllUsers() {
        let context = CoreDataStack.shared.viewContext(for: "UserModel")
        let request: NSFetchRequest<NSFetchRequestResult> = User.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(deleteRequest)
            CoreDataStack.shared.saveContext(for: "UserModel")
        } catch {
            print("Delete error: \(error)")
        }
    }
}
