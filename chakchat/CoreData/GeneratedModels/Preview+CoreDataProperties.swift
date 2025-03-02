//
//  Preview+CoreDataProperties.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.02.2025.
//
//

import Foundation
import CoreData


extension Preview {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Preview> {
        return NSFetchRequest<Preview>(entityName: "Preview")
    }

    @NSManaged public var updateID: Int64
    @NSManaged public var chatID: UUID?
    @NSManaged public var senderID: UUID?
    @NSManaged public var createdAt: Date?
    @NSManaged public var chat: ChatData?
    @NSManaged public var content: Content?
    @NSManaged public var reactions: NSSet?

}

// MARK: Generated accessors for reactions
extension Preview {

    @objc(addReactionsObject:)
    @NSManaged public func addToReactions(_ value: Reaction)

    @objc(removeReactionsObject:)
    @NSManaged public func removeFromReactions(_ value: Reaction)

    @objc(addReactions:)
    @NSManaged public func addToReactions(_ values: NSSet)

    @objc(removeReactions:)
    @NSManaged public func removeFromReactions(_ values: NSSet)

}

extension Preview : Identifiable {

}
