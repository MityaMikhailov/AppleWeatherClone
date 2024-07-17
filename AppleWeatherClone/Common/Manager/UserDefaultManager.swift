//
//  UserDefaultManager.swift
//  AppleWeatherClone
//
//  Created by Dmitriy Mikhailov on 17.07.2024.
//

import Foundation

class UserDefaultManager<T: Codable> {
    
    var key: String
    
    init(key: String) {
        self.key = key
    }
    
    func loadItems() -> [T]? {
        if let savedData = UserDefaults.standard.data(forKey: key) {
            let decoder = JSONDecoder()
            if let loadedResults = try? decoder.decode([T].self, from: savedData) {
                return loadedResults
            }
        }
        return nil
    }
    
    func addItem(_ info: T) {
        var results = loadItems() ?? []
        results.append(info)
        saveItem(results)
    }
    
    func addFirstItem(_ info: T) {
        var results = loadItems() ?? []
            if results.isEmpty {
                results.append(info)
            } else {
                results[0] = info 
            }
            saveItem(results)
    }
    
    func saveItem(_ results: [T]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(results) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func printUserDefaults() {
        let defaultsDict = UserDefaults.standard.dictionaryRepresentation()
        if !defaultsDict.isEmpty {
            print("Содержимое UserDefaults:")
            for (key, value) in defaultsDict {
                print("\(key): \(value)")
            }
        } else {
            print("UserDefaults пуст или не удалось получить данные.")
        }
    }
}
