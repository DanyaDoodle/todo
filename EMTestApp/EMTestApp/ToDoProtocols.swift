//
//  ToDoProtocols.swift
//  vremenno
//
//  Created by Даниил Кондауров on 30.10.2025.
//

import Foundation

protocol ToDoInteractorInputProtocol: AnyObject {
    func getToDo()
    func addToDo(todo: String)
    func toggleCompleted(item: ToDoItem)
}

protocol ToDoInteractorOutputProtocol: AnyObject {
    func didFetchToDos(_ todos: [ToDoItem])
    func didFailToFetchToDos(_ error: Error)
    func didAddToDoItem(_ todo: ToDoItem)
}

protocol ToDoPresenterInputProtocol: AnyObject {
    func viewDidLoad()
    func didTapAddToDoButton(with text: String)
    func didToggleCompleted(for item: ToDoItem)
}

protocol ToDoPresenterOutputProtocol: AnyObject {
    func showToDoList(_ todos: [ToDoItem])
    func showAddedToDoItem(_ todo: ToDoItem)
    func updateToDoItem(_ item: ToDoItem)
}

protocol ToDoViewInputProtocol: AnyObject {
    func showToDoList(_ todos: [ToDoItem])
    func showAddedToDoItem(_ todo: ToDoItem)
    func updateToDoItem(_ item: ToDoItem)
}

protocol ToDoViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func didTapAddToDoButton(with text: String)
    func didToggleCompleted(for item: ToDoItem)
}
