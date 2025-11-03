//
//  ToDoItem+CoreDataProperties.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 03.11.2025.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var id: Int64
    @NSManaged public var todo: String
    @NSManaged public var userId: Int64
    @NSManaged public var creationDate: Date?

}

extension ToDoItem : Identifiable {

}
