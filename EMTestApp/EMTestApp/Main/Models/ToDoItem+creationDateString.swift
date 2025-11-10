//
//  ToDoItem+creationDateString.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 08.11.2025.
//

import Foundation

extension ToDoItem {
    var creationDateString: String {
        guard let date = creationDate else { return "30/10/25" }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: date)
    }
}
