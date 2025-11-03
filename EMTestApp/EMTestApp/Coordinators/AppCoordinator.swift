//
//  AppCoordinator.swift
//  vremenno
//
//  Created by Даниил Кондауров on 28.10.2025.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var result: ((StartScreen) -> Void)?
    private let window: UIWindow
    private var navigationController: UINavigationController?
    private var mainCoordinator: ToDoCoordinator?
    
    // MARK: - Init
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Start
    
    func start() {
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        
        let mainCoordinator = ToDoCoordinator(navigationController: navigationController)
        self.mainCoordinator = mainCoordinator
        
        mainCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
