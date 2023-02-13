//
//  File.swift
//  UrlProject
//
//  Created by Olha Dzhyhirei on 2/4/23.
//

import UIKit


struct JokeData: Decodable, Equatable {
    let id: String
    let value: String
    let categories: [String]
    let created_at: String
}

struct SearchData: Decodable {
    let result: [JokeData]
}


struct JokeNetworkManager {
    static let shared = JokeNetworkManager()
    
    let randomJokeUrl = "https://api.chucknorris.io/jokes/random"
    let categorysUrl = "https://api.chucknorris.io/jokes/categories"
    let jokeOfCategoryUrl = "https://api.chucknorris.io/jokes/random?category="
    let search = "https://api.chucknorris.io/jokes/search?query="
    
    
    func fetchSearchedJokes(for word: String, completion: @escaping (Result<SearchData, Error>) -> Void) {
        let link = JokeNetworkManager.shared.search + word
        JokeNetworkManager.shared.fetchData(link: link, completion: completion)
    }
    
    func fetchCategorys(completion: @escaping (Result<[String], Error>) -> Void) {
        let link = JokeNetworkManager.shared.categorysUrl
        JokeNetworkManager.shared.fetchData(link: link, completion: completion)
    }
    
    func fetchJoke(category: String? = nil, completion: @escaping (Result<JokeData, Error>) -> Void) {
        let link = category == nil ? JokeNetworkManager.shared.randomJokeUrl :
        JokeNetworkManager.shared.jokeOfCategoryUrl + category!
        JokeNetworkManager.shared.fetchData(link: link, completion: completion)
    }
    
    func fetchData<T: Decodable>(link: String, completion: @escaping (Result<T, Error>) -> Void) {
        let url = URL(string: link)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: link, code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"])
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let jokeData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jokeData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

