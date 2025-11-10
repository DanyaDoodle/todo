//
//  ToDoInteractorOutputProtocol.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 02.11.2025.
//

import Foundation

protocol ToDoInteractorOutputProtocol: AnyObject {
    func didFetchToDos(_ todos: [ToDoItem])
    func didFailToFetchToDos(_ error: Error)
    func didAddToDoItem(_ todo: ToDoItem)
    func didDeleteToDoItem(_ todo: ToDoItem)
    func didSearchItems(_ todos: [ToDoItem])
}
