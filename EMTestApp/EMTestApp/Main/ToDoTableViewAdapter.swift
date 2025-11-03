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
    var onDelete: ((ToDoItem) -> Void)?
    var onEdit: ((ToDoItem) -> Void)?
    
    private var todos: [ToDoItem] = []
    private let identifier = "ToDoCell"
    private weak var tableView: UITableView?
    
    // MARK: - Init
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
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
    
    func delete(todo: ToDoItem) {
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else { return }
        todos.remove(at: index)
        tableView?.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
}

// MARK: - UITableViewDataSource

extension ToDoTableViewAdapter: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Unable to dequeue ToDoTableViewCell")
        }
        
        let todo = todos[indexPath.row]
        cell.configure(toDoText: todo.todo, isCompleted: todo.completed, index: indexPath.row + 1, creationDate: todo.creationDate)
        cell.selectionStyle = .none
        
        cell.onStatusTapped = { [weak self] in
            guard let self = self else { return }
            self.onToggleCompleted?(todo)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let todo = todos[indexPath.row]
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let delete = UIAction(
                title: "Удалить",
                image: UIImage(systemName: "trash"),
                attributes: .destructive
            ) { _ in
                let todo = self.todos[indexPath.row] 
                self.onDelete?(todo)
            }
            
            let share = UIAction(
                title: "Поделиться",
                image: UIImage(systemName: "square.and.arrow.up")) { _ in
                    print("share tapped")
                }
            
            let edit = UIAction(
                title: "Редактировать",
                image: UIImage(systemName: "square.and.pencil")) { _ in
                    self.onEdit?(todo)
                }
            
            return UIMenu(title: "", children: [edit, share, delete])
        }
    }
}


