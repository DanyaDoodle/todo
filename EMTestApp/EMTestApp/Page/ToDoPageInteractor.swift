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
    
    func fetchToDoDetail(by id: Int64) {
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        request.fetchLimit = 1
        do {
            if let todo = try context.fetch(request).first {
                output?.didFetchToDoDetail(todo: todo)
            }
        } catch {
            output?.didFailToFetchToDoDetail(error: error)
        }
    }
    
    func updateToDoText(todo: ToDoItem, with newText: String) {
        todo.todo = newText
        do {
            try context.save()
            output?.didUpdate(todo: todo)
        }
        catch {
            output?.didFailToFetchToDos(error: error)
        }
    }
}
