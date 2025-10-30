//
//  ToDoViewController.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 23.10.2025.
//

import UIKit

final class ToDoViewController: UIViewController, ToDoViewInputProtocol, FooterViewDelegate {
    
    var output: ToDoViewOutputProtocol?

    private let tableView = UITableView()
    private lazy var adapter = ToDoTableViewAdapter(tableView: tableView)
    private let footerView = FooterView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        footerView.delegate = self
        output?.viewDidLoad()

        adapter.onToggleCompleted = { [weak self] todo in
            self?.output?.didToggleCompleted(for: todo)
        }
    }

    func showToDoList(_ todos: [ToDoItem]) {
        adapter.update(todos: todos)
        footerView.footerConfigure(with: adapter.toDoCount())
    }

    func showAddedToDoItem(_ todo: ToDoItem) {
        adapter.add(todo: todo)
        footerView.footerConfigure(with: adapter.toDoCount())
    }

    func updateToDoItem(_ item: ToDoItem) {
        adapter.update(todo: item)
        footerView.footerConfigure(with: adapter.toDoCount())
    }

    func didTapAddToDo() {
        let alert = UIAlertController(title: "Новая задача", message: "Введите описание", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Описание" }
        let addAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] _ in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            self?.output?.didTapAddToDoButton(with: text)
        }
        alert.addAction(addAction)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
    // MARK: - Private
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        footerView.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1607843137, alpha: 1)
        
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
