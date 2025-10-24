//
//  URLManager.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 24.10.2025.
//

import Foundation

class URLManager {
    
    // MARK: - Singleton
    
    static let shared = URLManager(); private init() {}
    
    //MARK: - Properties
    
    private let tunnel = "https://"
    private let server = "dummyjson.com"
    
    //MARK: - Public Methods
    
    func createURL(endpoint: EndPoint) -> URL? {
        let str = tunnel + server + endpoint.path
        return URL(string: str)
    }
}

//MARK: - EndPoint

enum EndPoint {
    case todos
    
    var path: String {
        switch self {
        case .todos:
            return "/todos"
        }
    }
}
