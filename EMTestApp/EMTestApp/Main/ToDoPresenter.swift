//
//  ToDoPresenter.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 23.10.2025.
//

import Foundation

final class ToDoPresenter: ToDoPresenterInputProtocol, ToDoInteractorOutputProtocol, ToDoViewOutputProtocol {
    
    weak var view: ToDoViewInputProtocol?
    var interactor: ToDoInteractorInputProtocol?
    weak var coordinator: ToDoCoordinator?

    func viewDidLoad() {
        interactor?.getToDo()
    }
    
    func didTapAddToDoButton(with text: String) {
        interactor?.addToDo(todo: text)
    }
    
    func didToggleCompleted(for item: ToDoItem) {
        interactor?.toggleCompleted(item: item)
        view?.updateToDoItem(item)
    }

    func didFetchToDos(_ todos: [ToDoItem]) {
        view?.showToDoList(todos)
    }
    
    func didFailToFetchToDos(_ error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func didAddToDoItem(_ todo: ToDoItem) {
        view?.showAddedToDoItem(todo)
    }
    
    func didDeleteToDoItem(_ todo: ToDoItem) {
        view?.showDeleteToDoItem(todo)
    }
    
    func didTapDelete(for item: ToDoItem) {
        interactor?.deleteItem(item: item)
    }
    
    func didTapEdit(todo: ToDoItem) {
        coordinator?.showToDoPage(for: todo)
    }

}

