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
    
    private var todos: [ToDoEntity] = []
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
    
    func update(todos: [ToDoEntity]) {
        self.todos = todos
        tableView?.reloadData()
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
        
        cell.onStatusTapped = { [weak self] in
            guard let self = self else { return }
            self.todos[indexPath.row].completed.toggle()
            tableView.reloadData()
        }
        
        return cell
    }
}


