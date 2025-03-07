//
//  CoreDataManager.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.02.2025.
//

import Foundation
import CoreData

final class CoreDataManager: CoreDataManagerProtocol {
    
    func fetchChats() -> [PersonalChat]? {
        let context = CoreDataStack.shared.viewContext(for: "PersonalChatModel")
        let fetchRequest: NSFetchRequest<PersonalChat> = PersonalChat.fetchRequest()
        var result: [PersonalChat] = []
        do {
            let chats = try context.fetch(fetchRequest)
            for chat in chats {
                result.append(chat)
            }
        } catch {
            print("Failed to fetch chats: \(error)")
            return nil
        }
        return result
    }
    
    func createPersonalChat(_ chatData: ChatsModels.PersonalChat.Response) {
        let context = CoreDataStack.shared.viewContext(for: "PersonalChatModel")
        let chat = PersonalChat(context: context)
        chat.chatID = chatData.chatID
        chat.members = (try? JSONEncoder().encode(chatData.members)) ?? Data()
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
    
    func updateChat(_ chatData: ChatsModels.PersonalChat.Response) {
        let context = CoreDataStack.shared.viewContext(for: "PersonalChatModel")
        
        let fetchRequest: NSFetchRequest<PersonalChat> = PersonalChat.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "chatID == %@", chatData.chatID as CVarArg)
        do {
            let chats = try context.fetch(fetchRequest)
            guard let chatToUpdate = chats.first else {
                print("No chat with id:\(chatData.chatID)")
                return
            }
            let newBlocked = chatData.blocked
            chatToUpdate.blocked = newBlocked
            if let newBlockedBy = chatData.blockedBy {
                chatToUpdate.blockedBy = try? JSONEncoder().encode(newBlockedBy)
            }
            let newCreatedAt = chatData.createdAt
            chatToUpdate.createdAt = newCreatedAt
            CoreDataStack.shared.saveContext(for: "PersonalChatModel")
            print("Chat with id:\(chatData.chatID) updated")
        } catch {
            print("Occurred error with chat(\(chatData.chatID)) update: \(error)")
        }
    }
    
    func deleteChat(_ chatID: UUID) {
        let context = CoreDataStack.shared.viewContext(for: "PersonalChatModel")
        let fetchRequest: NSFetchRequest<PersonalChat> = PersonalChat.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "chatID == %@", chatID as CVarArg)
        do {
            let chats = try context.fetch(fetchRequest)
            guard let chatToDelete = chats.first else {
                print("No chat with id:\(chatID)")
                return
            }
            context.delete(chatToDelete)
            CoreDataStack.shared.saveContext(for: "PersonalChatModel")
            print("Chat with id:\(chatID) updated")
        } catch {
            print("Occurred error with chat(\(chatID)) update: \(error)")
        }
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
