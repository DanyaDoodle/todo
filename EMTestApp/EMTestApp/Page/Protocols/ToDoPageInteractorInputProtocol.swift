//
//  ToDoPageInteractorInputProtocol.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 03.11.2025.
//

import Foundation

protocol ToDoPageInteractorInputProtocol: AnyObject {
    func fetchToDoDetail(by id: Int64)
    func updateToDoText(todo: ToDoItem, with newText: String)
}
