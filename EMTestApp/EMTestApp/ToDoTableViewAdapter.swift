//
//  ToDoTableViewAdapter.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 24.10.2025.
//

import UIKit

// MARK: - Adapter

class ToDoTableViewAdapter: NSObject {
    
    // MARK: - Nested Types
    
    typealias Cell = ToDoTableViewCell
    
    // MARK: - Properties
    
    var onToggleCompleted: ((ToDoItem) -> Void)?
    
    private var todos: [ToDoItem] = []
    private let identifier = "ToDoCell"
    private weak var tableView: UITableView?
    
    // MARK: - Init
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.register(Cell.self, forCellReuseIdentifier: identifier)
    }
    
    // MARK: - Public Methods
    
    func update(todos: [ToDoItem]) {
        self.todos = todos
        tableView?.reloadData()
    }
    
    func toDoCount() -> Int{
        return todos.count
    }
    
    func add(todo: ToDoItem) {
        todos.append(todo)
        tableView?.reloadData()
    }
    
    func update(todo: ToDoItem) {
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else { return }
        todos[index] = todo
        tableView?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }

    
}

// MARK: - UITableViewDataSource

extension ToDoTableViewAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Unable to dequeue ToDoTableViewCell")
        }
        
        let todo = todos[indexPath.row]
        cell.configure(toDoText: todo.todo, isCompleted: todo.completed)
        cell.selectionStyle = .none
        
        cell.onStatusTapped = { [weak self] in
            guard let self = self else { return }
            self.onToggleCompleted?(todo)
        }
        
        return cell
    }
}


