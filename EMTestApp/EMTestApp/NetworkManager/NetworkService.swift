//
//  NetworkService.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 24.10.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingFailed
    case requestFailed(Error)
}

final class NetworkService {
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    private var urlManager = URLManager()
    
    func getToDo(completion: @escaping (Result<[ToDoEntity], Error>) -> Void) {
        guard let url = urlManager.createURL(endpoint: .todos) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.requestFailed(error)))
                }
                return
            }
            
            guard let data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ToDoResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.todos))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.decodingFailed))
                }
            }
        }
        task.resume()
    }
}
