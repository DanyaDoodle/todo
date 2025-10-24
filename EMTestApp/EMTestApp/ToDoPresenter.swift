//
//  ToDoPresenter.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 23.10.2025.
//

import Foundation

protocol ToDoPresenterProtocol: AnyObject {
    func viewDidLoad()
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
    
    private func didFetchToDos(_ todos: [ToDoEntity]) {
        view?.showToDo(todos)
    }
}

