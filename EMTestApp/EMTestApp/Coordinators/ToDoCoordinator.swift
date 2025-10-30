//
//  ToDoCoordinator.swift
//  vremenno
//
//  Created by Даниил Кондауров on 28.10.2025.
//

import UIKit

final class ToDoCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    var result: ((StartScreen) -> Void)?
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Start
    
    func start() {
        let toDoVC = ToDoModuleBuilder.build(coordinator: self)
        navigationController.setViewControllers([toDoVC], animated: false)
    }
}
