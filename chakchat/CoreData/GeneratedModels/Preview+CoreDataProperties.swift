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
    @NSManaged public var createdAt: String?
    @NSManaged public var chatData: ChatData?
    @NSManaged public var contents: NSSet?

}

// MARK: Generated accessors for contents
extension Preview {

    @objc(addContentsObject:)
    @NSManaged public func addToContents(_ value: Content)

    @objc(removeContentsObject:)
    @NSManaged public func removeFromContents(_ value: Content)

    @objc(addContents:)
    @NSManaged public func addToContents(_ values: NSSet)

    @objc(removeContents:)
    @NSManaged public func removeFromContents(_ values: NSSet)

}

extension Preview : Identifiable {

}
