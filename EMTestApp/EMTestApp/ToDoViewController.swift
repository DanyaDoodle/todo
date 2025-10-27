//
//  ToDoViewController.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 23.10.2025.
//

import UIKit

// MARK: - View Protocol

protocol ToDoViewProtocol: AnyObject {
    func showToDo(_ toDo: [ToDoItem])
    func showAddToDo(todo: ToDoItem)
    func updateToDoItem(_ item: ToDoItem)
}

// MARK: - ViewController

class ToDoViewController: UIViewController, ToDoViewProtocol, FooterViewDelegate{
    
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
    
    private let footerView: FooterView = {
        let view = FooterView()
        view.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1607843137, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.viewDidLoad()
        footerView.delegate = self
        adapter.onToggleCompleted = { [weak self] todo in
            self?.presenter?.didToggleCompleted(for: todo)
        }
    }
    
    // MARK: - ToDoViewProtocol
    
    func showToDo(_ toDo: [ToDoItem]) {
        adapter.update(todos: toDo)
        footerView.footerConfigure(with: adapter.toDoCount())
    }
    
    func showAddToDo(todo: ToDoItem){
        adapter.add(todo: todo)
        footerView.footerConfigure(with: adapter.toDoCount())
    }
    
    func updateToDoItem(_ item: ToDoItem) {
        adapter.update(todo: item)
        footerView.footerConfigure(with: adapter.toDoCount())
    }
        
    // MARK: - didTapAddToDo func
    
    func didTapAddToDo() {
        let alert = UIAlertController(title: "Новая задача",
                                      message: "Введите описание",
                                      preferredStyle: .alert)
        
        alert.addTextField { $0.placeholder = "Описание" }
        
        let addAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            guard
                let field = alert.textFields?.first,
                let descriptionText = field.text, !descriptionText.isEmpty
            else { return }
            
            self?.presenter?.didAddToDoItem(todoDescription: descriptionText)
        }
        
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alert, animated: true)
    }
    
    // MARK: - Private
    
    private func setupTableView() {
        view.addSubview(footerView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 80),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor)
        ])
    }
}
