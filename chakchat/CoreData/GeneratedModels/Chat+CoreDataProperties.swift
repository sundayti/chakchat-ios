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

    @NSManaged public var chatID: UUID?
    @NSManaged public var type: String?
    @NSManaged public var members: Data?
    @NSManaged public var createdAt: Date?
    @NSManaged public var info: Data?

}

extension Chat : Identifiable {

}
