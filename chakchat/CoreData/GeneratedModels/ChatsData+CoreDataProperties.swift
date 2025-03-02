//
//  ChatsData+CoreDataProperties.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.02.2025.
//
//

import Foundation
import CoreData


extension ChatsData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatsData> {
        return NSFetchRequest<ChatsData>(entityName: "ChatsData")
    }

    @NSManaged public var chats: NSSet?

}

// MARK: Generated accessors for chats
extension ChatsData {

    @objc(addChatsObject:)
    @NSManaged public func addToChats(_ value: ChatData)

    @objc(removeChatsObject:)
    @NSManaged public func removeFromChats(_ value: ChatData)

    @objc(addChats:)
    @NSManaged public func addToChats(_ values: NSSet)

    @objc(removeChats:)
    @NSManaged public func removeFromChats(_ values: NSSet)

}

extension ChatsData : Identifiable {

}
