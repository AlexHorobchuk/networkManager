//
//  JokeSavingManager.swift
//  UrlProject
//
//  Created by Olha Dzhyhirei on 2/7/23.
//

import UIKit
import CoreData

struct JokeSavingManager {
    private init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let shared = JokeSavingManager()
    
    func getAllSavedJokes() -> [JokeData] {
        var jokes = [SavedJokes]()
        do {
            jokes = try context.fetch(SavedJokes.fetchRequest())
        }
        catch {
            print("cant get jokes")
        }
        var allSavedJokes = [JokeData]()
        jokes.forEach { joke in
            let newJoke = JokeData(id: joke.id!, value: joke.jokeText!, categories: [joke.category ?? "random"], created_at: joke.date!)
            allSavedJokes.append(newJoke)
        }
        return allSavedJokes
    }
    
    func saveJoke(joke: JokeData) {
        let newSavedJoke = SavedJokes(context: context)
        newSavedJoke.jokeText = joke.value
        newSavedJoke.category = joke.categories.first ?? "random"
        newSavedJoke.date = joke.created_at
        newSavedJoke.id = joke.id
        do {
            try context.save()
        }
        catch {
            print("couldn`t save a joke")
        }
        
    }
    
    func deleteJoke(joke: JokeData) {
        var jokes = [SavedJokes]()
        do {
            jokes = try context.fetch(SavedJokes.fetchRequest())
        }
        catch {
            print("cant get jokes")
        }
        jokes.forEach{ item in
            if item.id == joke.id {
                context.delete(item)
            }
        }
        do {
            try context.save()
        }
        catch {
            print("couldn`t delete a joke")
        }
    }
}
