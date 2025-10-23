//
//  ToDoViewController.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 23.10.2025.
//

import UIKit

//MARK: ToDoViewProtocol

protocol ToDoViewProtocol: AnyObject {
    func showToDo(_ toDo: [ToDoEntity])
}

class ToDoViewController: UIViewController, ToDoViewProtocol {
    
    var presenter: ToDoPresenterProtocol!
    private var todos: [ToDoEntity] = []
    private let identifier = "ToDoCell"
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .darkGray
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter.viewDidLoad()
    }
    
    func showToDo(_ toDo: [ToDoEntity]) {
        self.todos = toDo
        tableView.reloadData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ToDoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ToDoTableViewCell
        let todo = todos[indexPath.row]
        cell.configure(toDoText: todo.todo, isCompleted: todo.completed)
        
        cell.onStatusTapped = { [weak self] in
            guard let self = self else { return }
            self.todos[indexPath.row].completed.toggle()
            self.tableView.reloadData()
        }
        return cell
    }
}

