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
    
    func viewDidLoad(todoId: Int64) {
        interactor?.fetchToDoDetail(by: todoId)
    }
    
    func didFetchToDoDetail(todo: ToDoItem) {
        view?.displayToDoDetail(todo)
    }
    
    func didFailToFetchToDoDetail(error: Error) {
        view?.displayError(error)
    }
}
