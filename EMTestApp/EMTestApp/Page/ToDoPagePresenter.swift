//
//  ToDoPagePresenter.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 03.11.2025.
//

import Foundation

final class ToDoPagePresenter: ToDoPagePresenterInputProtocol, ToDoPageInteractorOutputProtocol, ToDoPageViewOutputProtocol{

    weak var view: ToDoPageViewInputProtocol?
    var interactor: ToDoPageInteractorInputProtocol?
    weak var coordinator: ToDoPageCoordinator?
    
    func viewDidLoad() {
        interactor?.fetchToDoDetail()
    }
    
    func didFetchToDoDetail(todo: ToDoItem) {
        view?.displayToDoDetail(todo)
    }
    
    func didFailToFetchToDoDetail(error: Error) {
        view?.displayError(error)
    }
    
    func didUpdate(todo: ToDoItem) {
        view?.displayToDoDetail(todo)
        coordinator?.onTodoUpdated?(todo)
    }
    
    func didFailToFetchToDos(error: any Error) {
        print(error)
    }
    
    func didEdit(todo: ToDoItem, newText: String) {
        interactor?.updateToDoText(todo: todo, with: newText)
    }
    
}
