//
//  ToDoPageCoordinator.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 03.11.2025.
//

import UIKit

final class ToDoPageCoordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    var result: ((StartScreen) -> Void)?
    var onTodoUpdated: ((ToDoItem) -> Void)?
    private var output: ToDoViewOutputProtocol?
    
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Start
    
    func start() {
        let todoPageVC = ToDoPageModuleBuilder.build(coordinator: self, todoId: 0)
        navigationController.pushViewController(todoPageVC, animated: true)
    }
}
