//
//  ToDoPresenterOutputProtocol.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 02.11.2025.
//

import Foundation

protocol ToDoPresenterOutputProtocol: AnyObject {
    func showToDoList(_ todos: [ToDoItem])
    func showAddedToDoItem(_ todo: ToDoItem)
    func updateToDoItem(_ item: ToDoItem)
    func showDeleteToDoItem(_ todo: ToDoItem)
}
