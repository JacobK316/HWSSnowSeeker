//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Jacob Kappler on 1/18/26.
//

import SwiftUI

@Observable
class Favorites {
    // the actual resorts the user had favorited
    private var resorts: Set<String>
    
    // the key used to read/write to UserDefaults
    private let key = "Favorites"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: key),
            let result = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = result
        } else {
            // still here? Use an empty array
            resorts = []
        }
    }
    
    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    // adds the resort to out set and saved the changes
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    // removes the resort from our set and saves the changes
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
