//
//  ToDoPageModuleBuilder.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 03.11.2025.
//

import UIKit

final class ToDoPageModuleBuilder {
    static func build(coordinator: ToDoPageCoordinator, todo: ToDoItem) -> UIViewController {
        let view = ToDoPageViewController()
        let presenter = ToDoPagePresenter()
        let interactor = ToDoPageInteractor(todo: todo)

        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.coordinator = coordinator
        interactor.output = presenter

        return view
    }
}

