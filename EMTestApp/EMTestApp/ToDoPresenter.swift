//
//  ToDoPresenter.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 23.10.2025.
//

import Foundation

protocol ToDoPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didAddToDoItem(todoDescription: String)
    func didAddToDoItem(todo: ToDoItem)
    func didToggleCompleted(for item: ToDoItem)
}

class ToDoPresenter: ToDoPresenterProtocol {
    
    weak var view: ToDoViewProtocol?
    var interactor: ToDoInteractorProtocol?
    var router: RouterProtocol?
    
    func viewDidLoad() {
        interactor?.getToDo { [weak self] result in
            switch result {
            case .success(let todos):
                self?.didFetchToDos(todos)
            case .failure(let error):
                print("Failed to fetch todos: \(error.localizedDescription)")
            }
        }
    }
    
    private func didFetchToDos(_ todos: [ToDoItem]) {
        view?.showToDo(todos)
    }
    
    func didAddToDoItem(todo: ToDoItem){
        view?.showAddToDo(todo: todo)
    }
    
    func didAddToDoItem(todoDescription: String) {
        interactor?.addToDo(todo: todoDescription)
    }
    
    func didToggleCompleted(for item: ToDoItem) {
        interactor?.toggleCompleted(item: item)
        view?.updateToDoItem(item)
    }
}

