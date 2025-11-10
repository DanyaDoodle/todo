//
//  ToDoPageViewInputProtocol.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 03.11.2025.
//

import Foundation

protocol ToDoPageViewInputProtocol: AnyObject {
    func displayToDoDetail(_ todo: ToDoItem)
    func displayError(_ error: Error)
}

