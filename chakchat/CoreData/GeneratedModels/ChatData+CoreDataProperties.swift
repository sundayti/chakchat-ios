//
//  ChatData+CoreDataProperties.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.02.2025.
//
//

import Foundation
import CoreData


extension ChatData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatData> {
        return NSFetchRequest<ChatData>(entityName: "ChatData")
    }

    @NSManaged public var chatID: UUID?
    @NSManaged public var type: String?
    @NSManaged public var secret: Bool
    @NSManaged public var name: String?
    @NSManaged public var chatPhoto: URL?
    @NSManaged public var lastUpdateID: Int64
    @NSManaged public var chatsData: ChatsData?
    @NSManaged public var previews: NSSet?

}

// MARK: Generated accessors for previews
extension ChatData {

    @objc(addPreviewsObject:)
    @NSManaged public func addToPreviews(_ value: Preview)

    @objc(removePreviewsObject:)
    @NSManaged public func removeFromPreviews(_ value: Preview)

    @objc(addPreviews:)
    @NSManaged public func addToPreviews(_ values: NSSet)

    @objc(removePreviews:)
    @NSManaged public func removeFromPreviews(_ values: NSSet)

}

extension ChatData : Identifiable {

}
