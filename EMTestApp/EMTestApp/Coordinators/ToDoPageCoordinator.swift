//
//  ToDoPageCoordinator.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 03.11.2025.
//

import UIKit

final class ToDoPageCoordinator {
    
    // MARK: - Properties
    
    private var navigationController: UINavigationController
    var result: ((StartScreen) -> Void)?
    var onTodoUpdated: ((ToDoItem) -> Void)?
    private var output: ToDoViewOutputProtocol?
    private var todoId: Int64
    
    // MARK: - Init
    
    init(navigationController: UINavigationController, todoId: Int64) {
        self.navigationController = navigationController
        self.todoId = todoId
    }
    
    // MARK: - Start
    
    func start() {
        let todoPageVC = ToDoPageModuleBuilder.build(coordinator: self, todoId: todoId)
        navigationController.pushViewController(todoPageVC, animated: true)
    }
}
