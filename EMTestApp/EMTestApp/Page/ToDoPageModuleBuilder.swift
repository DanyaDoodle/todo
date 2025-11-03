//
//  ToDoPageModuleBuilder.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 03.11.2025.
//

import UIKit

final class ToDoPageModuleBuilder {
    static func build(coordinator: ToDoPageCoordinator, todoId: Int64) -> UIViewController {
        let view = ToDoPageViewController()
        view.todoId = todoId

        let presenter = ToDoPagePresenter()
        let interactor = ToDoPageInteractor()

        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.coordinator = coordinator
        interactor.output = presenter

        return view
    }
}

