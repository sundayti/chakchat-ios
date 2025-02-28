//
//  FileContent+CoreDataProperties.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.02.2025.
//
//

import Foundation
import CoreData


extension FileContent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FileContent> {
        return NSFetchRequest<FileContent>(entityName: "FileContent")
    }

    @NSManaged public var file: Data?
    @NSManaged public var replyTo: UUID?
    @NSManaged public var forwarded: Bool
    @NSManaged public var reactions: NSSet?

}

// MARK: Generated accessors for reactions
extension FileContent {

    @objc(addReactionsObject:)
    @NSManaged public func addToReactions(_ value: Reaction)

    @objc(removeReactionsObject:)
    @NSManaged public func removeFromReactions(_ value: Reaction)

    @objc(addReactions:)
    @NSManaged public func addToReactions(_ values: NSSet)

    @objc(removeReactions:)
    @NSManaged public func removeFromReactions(_ values: NSSet)

}
