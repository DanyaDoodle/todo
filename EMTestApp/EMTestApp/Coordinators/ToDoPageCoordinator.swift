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
    var todoId: Int64?
    var result: ((StartScreen) -> Void)?
    private var output: ToDoViewOutputProtocol?
    
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Start
    
    func start() {
        guard let id = todoId else { return }
        let todoPageVC = ToDoPageModuleBuilder.build(coordinator: self, todoId: id)
        navigationController.pushViewController(todoPageVC, animated: true)
    }
}
