//
//  NetworkManager.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 13/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import Foundation


class NetworkManager {
    
    //MARK: Variables
    
    //MARK: Constants
    static let shared = NetworkManager()
    
    private let mainPath = "https://random-word-api.herokuapp.com"
    
    private init() {}
    
    func requestRandomWords(numberOfWords: Int, completed: @escaping (Result<[String], NetworkError>)->()) {
        
        guard let url = URL(string: createURL(numberOfWords: numberOfWords)) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let words = try decoder.decode([String].self, from: data)
                completed(.success(words))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    private func createURL(numberOfWords: Int) -> String {
        let urlString = mainPath + "/word?number=\(numberOfWords)"
        return urlString
    }
    
}
