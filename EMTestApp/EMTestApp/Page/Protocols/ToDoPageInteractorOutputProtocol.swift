//
//  ToDoPageInteractorOutputProtocol.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 03.11.2025.
//

import Foundation

protocol ToDoPageInteractorOutputProtocol: AnyObject {
    func didFetchToDoDetail(todo: ToDoItem)
    func didFailToFetchToDoDetail(error: Error)
}
