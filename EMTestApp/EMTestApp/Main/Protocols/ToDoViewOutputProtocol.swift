//
//  ToDoViewOutputProtocol.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 02.11.2025.
//

import Foundation

protocol ToDoViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func didTapAddToDoButton(with text: String)
    func didToggleCompleted(for item: ToDoItem)
    func didTapDelete(for item: ToDoItem)
    func didTapEdit(todo: ToDoItem)
}
