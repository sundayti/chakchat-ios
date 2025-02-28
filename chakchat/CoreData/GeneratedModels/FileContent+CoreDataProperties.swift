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
    @NSManaged public var content: Content?

}
