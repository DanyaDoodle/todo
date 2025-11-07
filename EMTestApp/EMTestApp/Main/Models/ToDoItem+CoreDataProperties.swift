//
//  ToDoItem+CoreDataProperties.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 04.11.2025.
//
//

import Foundation
import CoreData
import UIKit

extension ToDoItem {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }
    
    @NSManaged public var completed: Bool
    @NSManaged public var id: Int64
    @NSManaged public var todo: String
    @NSManaged public var userId: Int64
    @NSManaged public var creationDate: Date?
    @NSManaged public var title: String
    
}

extension ToDoItem : Identifiable {
    
}

extension ToDoItem {
    var creationDateString: String {
        guard let date = creationDate else { return "30/10/25" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: date)
    }
}
