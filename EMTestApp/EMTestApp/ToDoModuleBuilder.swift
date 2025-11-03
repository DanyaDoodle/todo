//
//  ToDoModuleBuilder.swift
//  vremenno
//
//  Created by Даниил Кондауров on 28.10.2025.
//

import UIKit

final class ToDoModuleBuilder {
    
    static func build(coordinator: ToDoCoordinator) -> UIViewController {
        let view = ToDoViewController()
        let presenter = ToDoPresenter()
        let interactor = ToDoInteractor()
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.coordinator = coordinator
        interactor.output = presenter
        coordinator.setOutput(presenter)
        
        return view
    }
}

