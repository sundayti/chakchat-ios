//
//  TextContent+CoreDataProperties.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.02.2025.
//
//

import Foundation
import CoreData


extension TextContent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TextContent> {
        return NSFetchRequest<TextContent>(entityName: "TextContent")
    }

    @NSManaged public var text: String?
    @NSManaged public var replyTo: UUID?
    @NSManaged public var forwarded: Bool
    @NSManaged public var content: Content?

}
