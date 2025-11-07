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
    private var output: ToDoViewOutputProtocol?
    
    // MARK: - Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setOutput(_ output: ToDoViewOutputProtocol) {
        self.output = output
    }
    
    // MARK: - Start
    
    func start() {
        guard let toDoVC = ToDoModuleBuilder.build(coordinator: self) as? ToDoViewController else { return }
        toDoVC.showAddAllert = { [weak self] in
            self?.showAddItemModal()
        }
        navigationController.setViewControllers([toDoVC], animated: false)
    }
    
    func showAddItemModal() {
        let alert = UIAlertController(title: "Новая задача", message: "Введите описание", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Описание" }
        let addAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            self?.output?.didTapAddToDoButton(with: text)
        }
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        navigationController.present(alert, animated: true)
    }
    
    func showToDoPage(for todo: ToDoItem) {
        let pageCoordinator = ToDoPageCoordinator(navigationController: navigationController)
        
        pageCoordinator.onTodoUpdated = { [weak self] updatedTodo in
            guard let mainVC = self?.navigationController.viewControllers.first as? ToDoViewController else { return }
            mainVC.updateToDoItem(updatedTodo)
        }
        
        navigationController.pushViewController(
            ToDoPageModuleBuilder.build(coordinator: pageCoordinator, todoId: todo.id),
            animated: false
        )
    }

}
