//
//  ToDoEntity.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 23.10.2025.
//

import Foundation

struct ToDoEntity: Codable {
    var id: Int
    var todo: String
    var completed: Bool
    var userId: Int
}
