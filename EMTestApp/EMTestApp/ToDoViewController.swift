//
//  ToDoViewController.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 23.10.2025.
//

import UIKit

// MARK: - View Protocol

protocol ToDoViewProtocol: AnyObject {
    func showToDo(_ toDo: [ToDoEntity])
}

// MARK: - ViewController

class ToDoViewController: UIViewController, ToDoViewProtocol {
    
    // MARK: - Properties
    
    var presenter: ToDoPresenterProtocol?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .darkGray
        return tableView
    }()
    
    private lazy var adapter: ToDoTableViewAdapter = {
        return ToDoTableViewAdapter(tableView: tableView)
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    // MARK: - ToDoViewProtocol
    
    func showToDo(_ toDo: [ToDoEntity]) {
        adapter.update(todos: toDo)
    }
    
    // MARK: - Private
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
