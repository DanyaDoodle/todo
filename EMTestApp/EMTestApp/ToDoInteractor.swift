//
//  ToDoInteractor.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 23.10.2025.
//

import Foundation
import CoreData

final class ToDoInteractor: ToDoInteractorInputProtocol {

    weak var output: ToDoInteractorOutputProtocol?
    private var networkService = NetworkService()
    private var context = CoreDataManager.shared.context

    func getToDo() {
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        do {
            let localTodos = try context.fetch(request)
            if !localTodos.isEmpty {
                output?.didFetchToDos(localTodos)
                return
            }
        } catch {
            output?.didFailToFetchToDos(error)
            return
        }

        networkService.getToDo { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let todos):
                var savedItems: [ToDoItem] = []
                for todo in todos {
                    let item = ToDoItem(context: self.context)
                    item.id = Int64(todo.id)
                    item.todo = todo.todo
                    item.completed = todo.completed
                    item.userId = Int64(todo.userId)
                    savedItems.append(item)
                }
                do {
                    try self.context.save()
                    self.output?.didFetchToDos(savedItems)
                } catch {
                    self.output?.didFailToFetchToDos(error)
                }
            case .failure(let error):
                self.output?.didFailToFetchToDos(error)
            }
        }
    }

    func addToDo(todo: String) {
        let newItem = ToDoItem(context: context)
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        request.fetchLimit = 1
        var nextId: Int64 = 1
        if let lastItem = try? context.fetch(request).first {
            nextId = lastItem.id + 1
        }

        newItem.id = nextId
        newItem.todo = todo
        newItem.completed = false
        newItem.userId = 1
        
        do {
            try context.save()
            output?.didAddToDoItem(newItem)
        } catch {
            output?.didFailToFetchToDos(error)
        }
    }
    
    func toggleCompleted(item: ToDoItem) {
        item.completed.toggle()
        do {
            try context.save()
        } catch {}
    }
}

