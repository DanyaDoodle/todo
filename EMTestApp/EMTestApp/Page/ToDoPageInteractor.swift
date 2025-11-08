//
//  ToDoPageInteractor.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 03.11.2025.
//

import Foundation
import CoreData

final class ToDoPageInteractor: ToDoPageInteractorInputProtocol {
    
    weak var output: ToDoPageInteractorOutputProtocol?
    private let context = CoreDataManager.shared.context
    private var todo: ToDoItem
    
    init(todo: ToDoItem) {
         self.todo = todo
     }
    
    func fetchToDoDetail() {
        output?.didFetchToDoDetail(todo: todo)
    }
    
    func updateToDoText(todo: ToDoItem, with newText: String) {
        todo.todo = newText
        do {
            try context.save()
            context.refresh(todo, mergeChanges: true)
            output?.didUpdate(todo: todo)
        }
        catch {
            output?.didFailToFetchToDos(error: error)
        }
    }
}
