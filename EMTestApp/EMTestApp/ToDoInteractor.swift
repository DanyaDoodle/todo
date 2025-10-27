//
//  ToDoInteractor.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 23.10.2025.
//

import Foundation
import CoreData

protocol ToDoInteractorProtocol: AnyObject {
    func getToDo(completion: @escaping (Result<[ToDoItem], Error>) -> Void)
    func addToDo(todo: String)
    func toggleCompleted(item: ToDoItem)
}

class ToDoInteractor: ToDoInteractorProtocol {
    
    var presenter: ToDoPresenterProtocol?
    private var networkService = NetworkService()
    private var context = CoreDataManager.shared.context
    
    func getToDo(completion: @escaping (Result<[ToDoItem], Error>) -> Void) {
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        do {
            let localTodos = try context.fetch(request)
            if !localTodos.isEmpty {
                DispatchQueue.main.async {
                    completion(.success(localTodos))
                }
                return
            }
        } catch {
            print("Failed to fetch local todos: \(error)")
        }

        networkService.getToDo { [weak self] result in
            guard let self = self else { return }
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
                    DispatchQueue.main.async {
                        completion(.success(savedItems))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
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
            presenter?.didAddToDoItem(todo: newItem)
        } catch {
            print("Failed to save ToDoItem: \(error)")
        }
    }
    
    func toggleCompleted(item: ToDoItem) {
        item.completed.toggle()
        do {
            try context.save()
        } catch {
            print("\(error)")
        }
    }
}
