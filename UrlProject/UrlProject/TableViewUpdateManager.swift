//
//  Manager.swift
//  UrlProject
//
//  Created by Olha Dzhyhirei on 2/11/23.
//

import UIKit

extension NSNotification.Name{
    static let updateSavedJokes = NSNotification.Name("Update jokes")
}

struct TableViewUpdateManager {
    private init() {}
    static var shared = TableViewUpdateManager()
    
    func updateFavoriteJokes() {
        NotificationCenter.default.post(
            Notification(name: .updateSavedJokes,
                        object: nil))
    }
}
