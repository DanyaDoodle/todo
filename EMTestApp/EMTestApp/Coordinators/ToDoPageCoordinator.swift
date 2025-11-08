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
    private var todoItem: ToDoItem
    
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.todoItem = ToDoItem()
    }
    
    // MARK: - Start
    
    func start() {
        let todoPageVC = ToDoPageModuleBuilder.build(coordinator: self, todo: todoItem)
        navigationController.pushViewController(todoPageVC, animated: true)
    }
}
