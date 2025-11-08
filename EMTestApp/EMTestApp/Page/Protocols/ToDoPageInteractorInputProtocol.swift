//
//  ToDoPageInteractorInputProtocol.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 03.11.2025.
//

import Foundation

protocol ToDoPageInteractorInputProtocol: AnyObject {
    func fetchToDoDetail()
    func updateToDoText(todo: ToDoItem, with newText: String)
}
