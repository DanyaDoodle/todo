//
//  Coordinator.swift
//  vremenno
//
//  Created by Даниил Кондауров on 28.10.2025.
//

import UIKit

protocol Coordinator {
    var result: ((StartScreen) -> Void)? { get set }
    func start()
}

