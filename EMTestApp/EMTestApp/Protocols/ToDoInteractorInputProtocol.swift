//
//  ToDoInteractorInputProtocol.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 02.11.2025.
//

import Foundation

protocol ToDoInteractorInputProtocol: AnyObject {
    func getToDo()
    func addToDo(todo: String)
    func toggleCompleted(item: ToDoItem)
}
