//
//  ToDoPageViewController.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 03.11.2025.
//

import UIKit

class ToDoPageViewController: UIViewController, ToDoPageViewInputProtocol, UITextViewDelegate {
    
    var output: ToDoPageViewOutputProtocol?
    private var currentItem: ToDoItem?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .medium)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toDoTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.textColor = .white
        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        toDoTextView.delegate = self
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let todo = currentItem else { return }
        
        if toDoTextView.text != todo.todo {
            output?.didEdit(todo: todo, newText: toDoTextView.text)
        }
    }
    
    func displayToDoDetail(_ todo: ToDoItem) {
        currentItem = todo
        titleLabel.text = todo.title
        toDoTextView.text = todo.todo
        dateLabel.text = todo.creationDateString
    }
    
    func displayError(_ error: Error) {
        print(error)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    private func setupUI(){
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.addSubview(toDoTextView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            toDoTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            toDoTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toDoTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

    }
}
