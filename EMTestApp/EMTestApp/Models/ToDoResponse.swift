//
//  ToDoResponse.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 24.10.2025.
//

import Foundation

struct ToDoResponse: Decodable {
    let todos: [ToDoEntity]
}
