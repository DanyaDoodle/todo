//
//  ToDoInteractor.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 23.10.2025.
//

import Foundation

protocol ToDoInteractorProtocol: AnyObject {
    func getToDo(completion: @escaping (Result<[ToDoEntity], Error>) -> Void)
}

class ToDoInteractor: ToDoInteractorProtocol {
    
    var presenter: ToDoPresenterProtocol?
    private var networkService = NetworkService()
    
    func getToDo(completion: @escaping (Result<[ToDoEntity], Error>) -> Void) {
        networkService.getToDo(completion: completion)
    }
}
