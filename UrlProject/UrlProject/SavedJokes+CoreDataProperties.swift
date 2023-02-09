//
//  SavedJokes+CoreDataProperties.swift
//  UrlProject
//
//  Created by Olha Dzhyhirei on 2/7/23.
//
//

import Foundation
import CoreData


extension SavedJokes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedJokes> {
        return NSFetchRequest<SavedJokes>(entityName: "SavedJokes")
    }
    @NSManaged public var jokeText: String?
    @NSManaged public var id: String?
    @NSManaged public var category: String?
    @NSManaged public var date: String?
}

extension SavedJokes : Identifiable {
}
