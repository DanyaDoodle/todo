//
//  ToDoViewController.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 23.10.2025.
//

import UIKit

final class ToDoViewController: UIViewController, ToDoViewInputProtocol, FooterViewDelegate {
    
    var output: ToDoViewOutputProtocol?
    var showAddAllert: (() -> Void)?

    private let tableView = UITableView()
    private lazy var adapter = ToDoTableViewAdapter(tableView: tableView)
    private let footerView = FooterView()
    
    private var navBarAppearance: UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        return appearance
    }
    
    private let searchController: UISearchController = {
        let search = UISearchController()
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search"
        search.searchBar.sizeToFit()
        search.searchBar.barStyle = .black
        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        footerView.delegate = self
        searchController.searchBar.delegate = self
        output?.viewDidLoad()

        adapter.onToggleCompleted = { [weak self] todo in
            self?.output?.didToggleCompleted(for: todo)
        }
        
        adapter.onDelete = { [weak self] todo in
            self?.output?.didTapDelete(for: todo)
        }
        
        adapter.onEdit = { [weak self] todo in
            self?.output?.didTapEdit(todo: todo)
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
        showAddAllert?()
    }
    
    func showDeleteToDoItem(_ todo: ToDoItem) {
        adapter.delete(todo: todo)
        footerView.footerConfigure(with: adapter.toDoCount())
    }
    
    // MARK: - Private
    
    private func setupNavigationBar() {
        title = "Задачи"
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
    
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

extension ToDoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output?.didUpdateSearchText(searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        output?.didUpdateSearchText("")
    }
}
