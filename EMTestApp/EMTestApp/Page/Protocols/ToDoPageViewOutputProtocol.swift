//
//  ToDoPageViewOutputProtocol.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 03.11.2025.
//

import Foundation

protocol ToDoPageViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func didEdit(todo: ToDoItem, newText: String)
}
