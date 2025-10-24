//
//  NetworkService.swift
//  EMTestApp
//
//  Created by Даниил Кондауров on 24.10.2025.
//

import Foundation

final class NetworkService {
    
    //MARK: - Public Methods
    
    func getToDo(completion: @escaping (Result<[ToDoEntity], Error>) -> Void) {
        guard let url = URLManager.shared.createURL(endpoint: .todos) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ToDoResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.todos))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
