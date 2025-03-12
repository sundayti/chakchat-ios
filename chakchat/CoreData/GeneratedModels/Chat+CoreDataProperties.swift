//
//  Chat+CoreDataProperties.swift
//  chakchat
//
//  Created by Кирилл Исаев on 11.03.2025.
//
//

import Foundation
import CoreData


extension Chat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chat> {
        return NSFetchRequest<Chat>(entityName: "Chat")
    }

    @NSManaged public var chatID: UUID
    @NSManaged public var type: String
    @NSManaged public var members: Data
    @NSManaged public var createdAt: Date
    @NSManaged public var info: Data

}

extension Chat : Identifiable {
    
}

extension Chat {
    func getMembers() -> [UUID] {
        let decoder = JSONDecoder()
        if let members = try? decoder.decode([UUID].self, from: self.members) {
            return members
        }
        return []
    }
    
    func toChatData() throws -> ChatsModels.GeneralChatModel.ChatData {
        let members = try JSONDecoder().decode([UUID].self, from: self.members)
        let info: ChatsModels.GeneralChatModel.Info
        do {
            if let personalInfo = try? JSONDecoder().decode(ChatsModels.GeneralChatModel.PersonalInfo.self, from: self.info) {
                info = .personal(personalInfo)
            } else if let groupInfo = try? JSONDecoder().decode(ChatsModels.GeneralChatModel.GroupInfo.self, from: self.info) {
                info = .group(groupInfo)
            } else if let secretPersonalInfo = try? JSONDecoder().decode(ChatsModels.GeneralChatModel.SecretPersonalInfo.self, from: self.info) {
                info = .secretPersonal(secretPersonalInfo)
            } else if let secretGroupInfo = try? JSONDecoder().decode(ChatsModels.GeneralChatModel.SecretGroupInfo.self, from: self.info) {
                info = .secretGroup(secretGroupInfo)
            } else {
                throw NSError(domain: "ChatConversionError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown info type"])
            }
        } catch {
            throw error
        }
        
        return ChatsModels.GeneralChatModel.ChatData(
            chatID: self.chatID,
            type: ChatType(rawValue: self.type) ?? .personal,
            members: members,
            createdAt: self.createdAt,
            info: info
        )
    }
}
