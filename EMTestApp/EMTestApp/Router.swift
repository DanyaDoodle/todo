//
//  Router.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 23.10.2025.
//

import UIKit

protocol RouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

class Router: RouterProtocol{
    
    static func createModule() -> UIViewController {
        let view = ToDoViewController()
        let presenter = ToDoPresenter()
        let interactor = ToDoInteractor()
        let router = Router()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}
