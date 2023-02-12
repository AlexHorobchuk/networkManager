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
    
    enum fetchingType {
        case joke
        case categorys
        case search
    }
    
    func fetchData(category: String? = nil, searchForWord search: String? = nil, fetchingtype: fetchingType, completion: @escaping (Result<Any, Error>) -> Void) {
        let link = self.getUrl(requestType: fetchingtype, category: category, searchForWord: search)
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
                switch fetchingtype {
                    
                case .joke:
                    let jokeData = try JSONDecoder().decode(JokeData.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(jokeData))
                    }
                case .categorys:
                    let categorysData = try JSONDecoder().decode([String].self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(categorysData))
                    }
                case .search:
                    let searchedJoke = try JSONDecoder().decode(SearchData.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(searchedJoke))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getUrl(requestType: fetchingType, category: String?, searchForWord: String?) -> String {
        switch requestType {
        case .joke:
            guard let category = category else {
                return JokeNetworkManager.shared.randomJokeUrl
            }
            return JokeNetworkManager.shared.jokeOfCategoryUrl + category
        case .categorys:
            return JokeNetworkManager.shared.categorysUrl
        case .search:
            return JokeNetworkManager.shared.search + searchForWord!
        }
    }
    
}

