//
//  PersonalChat+CoreDataProperties.swift
//  chakchat
//
//  Created by Кирилл Исаев on 06.03.2025.
//
//

import Foundation
import CoreData


extension PersonalChat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonalChat> {
        return NSFetchRequest<PersonalChat>(entityName: "PersonalChat")
    }

    @NSManaged public var blocked: Bool
    @NSManaged public var blockedBy: Data?
    @NSManaged public var chatID: UUID?
    @NSManaged public var createdAt: Date?
    @NSManaged public var members: Data?

}

extension PersonalChat : Identifiable {

}
