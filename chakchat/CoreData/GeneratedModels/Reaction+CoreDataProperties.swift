//
//  Reaction+CoreDataProperties.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.02.2025.
//
//

import Foundation
import CoreData


extension Reaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reaction> {
        return NSFetchRequest<Reaction>(entityName: "Reaction")
    }

    @NSManaged public var reactionContent: ReactionContent?
    @NSManaged public var textContent: TextContent?
    @NSManaged public var fileContent: FileContent?

}
