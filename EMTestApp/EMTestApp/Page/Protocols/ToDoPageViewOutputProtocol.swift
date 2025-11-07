//
//  ToDoPageViewOutputProtocol.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 03.11.2025.
//

import Foundation

protocol ToDoPageViewOutputProtocol: AnyObject {
    func viewDidLoad(todoId: Int64)
    func didEdit(todo: ToDoItem, newText: String)
}
